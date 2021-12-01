resource "aws_ssm_parameter" "public_subnets_ids" {
  name        = "/Dev/vpc/public_subnet_ids"
  description = "List with the IDs of the public subnets."
  type        = "StringList"
  value       = join(",", aws_subnet.public_subnets.*.id)

  tags = merge(local.tags, {
    Name = var.prefix
  })
}

resource "aws_ssm_parameter" "private_subnets_ids" {
  name        = "/Dev/vpc/private_subnets_ids"
  description = "List with the IDs of the private subnets."
  type        = "StringList"
  value       = join(",", aws_subnet.private_subnets.*.id)

  tags = merge(local.tags, {
    Name = var.prefix
  })
}

resource "aws_ssm_parameter" "airflow_bucket_name" {
  name        = "/Dev/s3/airflow_bucket_name"
  description = "Name of S3 bucket used to store dags."
  type        = "String"
  value       = aws_s3_bucket.s3_bucket.bucket

  tags = merge(local.tags, {
    Name = var.prefix
  })
}

resource "aws_ssm_parameter" "airflow_bucket_id" {
  name        = "/Dev/s3/airflow_bucket_id"
  description = "S3 bucket ID used to store Airflow dags."
  type        = "String"
  value       = aws_s3_bucket.s3_bucket.id

  tags = merge(local.tags, {
    Name = var.prefix
  })
}

resource "aws_ssm_parameter" "mwaa_environment_arn" {
  name        = "/Dev/mwaa/mwaa_environment_arn"
  description = "ARN of MWAA environment."
  type        = "String"
  value       = aws_mwaa_environment.mwaa_environment.arn

  tags = merge(local.tags, {
    Name = var.prefix
  })
}

resource "aws_ssm_parameter" "mwaa_webserver_url" {
  name        = "/Dev/mwaa/mwaa_webserver_url"
  description = "Webserver URL of MWAA environment."
  type        = "String"
  value       = aws_mwaa_environment.mwaa_environment.webserver_url

  tags = merge(local.tags, {
    Name = var.prefix
  })
}

resource "aws_ssm_parameter" "db_instance_endpoint" {
  name        = "/Dev/rds/db_instance_endpoint"
  description = "The RDS connection endpoint in address:port format."
  type        = "String"
  value       = aws_db_instance.db_instance.endpoint

  tags = merge(local.tags, {
    Name = var.prefix
  })
}
