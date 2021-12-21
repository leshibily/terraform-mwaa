# MWAA input variables

variable "aws_access_key" {
  sensitive = true
}
variable "aws_secret_key" {
  sensitive = true
}
variable "aws_session_token" {
  default   = ""
  sensitive = true
}

variable "region" {
  type        = string
  description = "AWS region where resources will be deployed."
}

variable "prefix" {
  type        = string
  description = "A prefix to use when naming resources."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID of the AWS VPC."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet ids"
}

variable "airflow_version" {
  type        = string
  description = "Airflow version"
  default     = "2.0.2"
}

variable "environment_class" {
  type        = string
  description = "The environment class of the Airflow cluster."
  default     = "mw1.small"
}

variable "min_workers" {
  type        = number
  description = "Minimum number of Airflow workers."
  default     = 1
}

variable "max_workers" {
  type        = number
  description = "Maximum number of Airflow workers."
  default     = 2
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional resource tags. Do not include the Name key."
  default     = {}
}