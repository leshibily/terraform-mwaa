# MWAA SSM Parameter store

resource "aws_ssm_parameter" "airflow_bucket_name" {
  name        = "/Dev/s3/airflow_bucket_name"
  description = "Name of S3 bucket used to store dags."
  type        = "String"
  value       = aws_s3_bucket.s3_bucket.bucket

  tags = merge(local.tags, {
    Name = "${var.prefix}-bucket-name"
  })
}

resource "aws_ssm_parameter" "airflow_bucket_id" {
  name        = "/Dev/s3/airflow_bucket_id"
  description = "S3 bucket ID used to store Airflow dags."
  type        = "String"
  value       = aws_s3_bucket.s3_bucket.id

  tags = merge(local.tags, {
    Name = "${var.prefix}-bucket-id"
  })
}

resource "aws_ssm_parameter" "mwaa_environment_arn" {
  name        = "/Dev/mwaa/mwaa_environment_arn"
  description = "ARN of MWAA environment."
  type        = "String"
  value       = aws_mwaa_environment.mwaa_environment.arn

  tags = merge(local.tags, {
    Name = "${var.prefix}-mwaa-environment-arn"
  })
}

resource "aws_ssm_parameter" "mwaa_webserver_url" {
  name        = "/Dev/mwaa/mwaa_webserver_url"
  description = "Webserver URL of MWAA environment."
  type        = "String"
  value       = aws_mwaa_environment.mwaa_environment.webserver_url

  tags = merge(local.tags, {
    Name = "${var.prefix}-mwaa_webserver_url"
  })
}
