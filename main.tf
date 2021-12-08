# MWAA Cluster

resource "aws_mwaa_environment" "mwaa_environment" {
  airflow_version       = var.airflow_version
  environment_class     = var.environment_class
  source_bucket_arn     = aws_s3_bucket.s3_bucket.arn
  dag_s3_path           = "dags"
  execution_role_arn    = aws_iam_role.airflow.arn
  name                  = var.prefix
  min_workers           = var.min_workers
  max_workers           = var.max_workers
  webserver_access_mode = "PRIVATE_ONLY"

  network_configuration {
    security_group_ids = [aws_security_group.mwaa.id]
    subnet_ids         = aws_subnet.private_subnets.*.id
  }

  logging_configuration {
    dag_processing_logs {
      enabled   = true
      log_level = "INFO"
    }

    scheduler_logs {
      enabled   = true
      log_level = "INFO"
    }

    task_logs {
      enabled   = true
      log_level = "INFO"
    }

    webserver_logs {
      enabled   = true
      log_level = "INFO"
    }

    worker_logs {
      enabled   = true
      log_level = "INFO"
    }
  }
  tags = merge(local.tags, {
    Name = "${var.prefix}-mwaa-environment"
  })
  depends_on = [
    aws_vpc_endpoint.s3,
    aws_vpc_endpoint.ecr_dkr,
    aws_vpc_endpoint.ecr_api,
    aws_vpc_endpoint.cloudwatch_logs,
    aws_vpc_endpoint.cloudwatch_monitoring,
    aws_vpc_endpoint.sqs,
    aws_vpc_endpoint.kms,
    aws_vpc_endpoint.airflow_api,
    aws_vpc_endpoint.airflow_env,
    aws_vpc_endpoint.airflow_ops
  ]
}
