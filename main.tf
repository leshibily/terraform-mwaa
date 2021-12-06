# MWAA Cluster

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  tags = merge(
    var.additional_tags,
    {
      provisioned_by = "Terraform"
    }
  )
}

resource "aws_iam_role" "airflow" {
  name = var.prefix
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "mwaa"
        Principal = {
          Service = [
            "airflow-env.amazonaws.com",
            "airflow.amazonaws.com"
          ]
        }
      },
    ]
  })

  tags = merge(local.tags, {
    Name = var.prefix
  })
}

data "aws_iam_policy_document" "airflow" {
  statement {
    sid       = ""
    actions   = ["airflow:PublishMetrics"]
    effect    = "Allow"
    resources = ["arn:aws:airflow:${var.region}:${local.account_id}:environment/${var.prefix}"]
  }

  statement {
    sid     = ""
    actions = ["s3:ListAllMyBuckets"]
    effect  = "Allow"
    resources = [
      aws_s3_bucket.s3_bucket.arn,
      "${aws_s3_bucket.s3_bucket.arn}/*"
    ]
  }

  statement {
    sid = ""
    actions = [
      "s3:GetObject*",
      "s3:GetBucket*",
      "s3:List*"
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.s3_bucket.arn,
      "${aws_s3_bucket.s3_bucket.arn}/*"
    ]
  }

  statement {
    sid       = ""
    actions   = ["logs:DescribeLogGroups"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = ""
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:GetLogRecord",
      "logs:GetLogGroupFields",
      "logs:GetQueryResults",
      "logs:DescribeLogGroups"
    ]
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:${local.account_id}:log-group:airflow-${var.prefix}*"]
  }

  statement {
    sid       = ""
    actions   = ["cloudwatch:PutMetricData"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = ""
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
    ]
    effect    = "Allow"
    resources = ["arn:aws:sqs:${var.region}:*:airflow-celery-*"]
  }

  statement {
    sid = ""
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt"
    ]
    effect        = "Allow"
    not_resources = ["arn:aws:kms:*:${local.account_id}:key/*"]
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values = [
        "sqs.${var.region}.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_policy" "airflow" {
  name   = var.prefix
  path   = "/"
  policy = data.aws_iam_policy_document.airflow.json
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role       = aws_iam_role.airflow.name
  policy_arn = aws_iam_policy.airflow.arn
}

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
    Name = var.prefix
  })
}
