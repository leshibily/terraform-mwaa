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

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnets' CIDR blocks."
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

variable "db_engine" {
  type        = string
  description = "Database engine"
}

variable "db_engine_version" {
  type        = string
  description = "Database engine version"
}

variable "db_instance_class" {
  type        = string
  description = "Database instance class"
}

variable "db_allocated_storage" {
  type        = string
  description = "Database storage allocation size"
}

variable "db_license_model" {
  type        = string
  description = "DB license model"
  default     = ""
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
}

variable "db_port" {
  type        = string
  description = "Database port"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional resource tags. Do not include the Name key."
  default     = {}
}