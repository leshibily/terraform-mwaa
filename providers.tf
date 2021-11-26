# MWAA providers

terraform {
  backend "s3" {
    # bucket = "airflow-terraform"
    # key    = "state/terraform.tfstate"
    # region = "ap-southeast-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.66.0"
    }
  }

  required_version = ">= 0.15.0, <= 1.0.11"
}

provider "aws" {
  region = var.region
}