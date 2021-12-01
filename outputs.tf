# MWAA output variables
output "public_subnets_ids" {
  value       = aws_subnet.public_subnets.*.id
  description = "List with the IDs of the public subnets."
}

output "private_subnets_ids" {
  value       = aws_subnet.private_subnets.*.id
  description = "List with the IDs of the private subnets."
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.s3_bucket.bucket
  description = "Name of S3 bucket used to store dags."
}

output "s3_bucket_id" {
  value       = aws_s3_bucket.s3_bucket.id
  description = "ID of S3 bucket."
}

output "mwaa_environment_arn" {
  value       = aws_mwaa_environment.mwaa_environment.arn
  description = "ARN of MWAA environment."
}

output "mwaa_webserver_url" {
  value       = aws_mwaa_environment.mwaa_environment.webserver_url
  description = "Webserver URL of MWAA environment."
}

output "db_instance_endpoint" {
  value       = aws_db_instance.db_instance.endpoint
  description = "The RDS connection endpoint in address:port format."
}
