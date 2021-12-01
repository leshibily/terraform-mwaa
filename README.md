# Terraform AWS MWAA

Tutorial for Amazon Managed Workflows for Apache Airflow (MWAA) with Terraform. This is a word for word translation of the official [AWS quick start](https://docs.aws.amazon.com/mwaa/latest/userguide/quick-start.html) (with CloudFormation).

## Prerequisites
1. Install Terraform v1.0.10.
2. Update the Terraform S3 backend in providers.tf (only for production).
3. Create a terraform.tfvars file in the root directory. Example below.

## Variables

Below is an example `terraform.tfvars` file that you can use in your deployments:

```ini
aws_access_key = "AKICGY7QD2Z74EXAMPLE"
aws_secret_key = "fVSlK+df5htRFRqxP7AFGsLy6K19pEOa7example"
region   = "ap-southeast-2"
prefix   = "airflow"
vpc_id = "vpc-01c8a77ac9example"
igw_id = "igw-02dee5327cexample"
# add private and public subnet cidrs based on your vpc cidr range. The below is for the VPC CIDR: 10.79.4.0/22
public_subnet_cidrs = [
  "10.79.4.192/27",
  "10.79.4.224/27"
]
private_subnet_cidrs = [
  "10.79.4.64/26",
  "10.79.4.128/26"
]
max_workers = 2

db_engine            = "oracle-se2"
db_engine_version    = "19.0.0.0.ru-2021-07.rur-2021-07.r1"
db_instance_class    = "db.t3.small"
db_allocated_storage = "50"
db_license_model     = "license-included"
db_name              = "ORCL"
db_username          = "admin"
db_password          = "Test1234"
db_port              = "1521"
```

## DAGs

There's a test DAG file inside the local [`dags` directory](./dags), which was taken from the official tutorial for [Apache Airflow v1.10.12](https://airflow.apache.org/docs/apache-airflow/1.10.12/tutorial.html#example-pipeline-definition). You can place as many DAG files inside that directory as you want and Terraform will pick them up and upload them to S3.

## Usage

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Make sure to keep the terraform state files safe, as they contain your access keys to the S3 bucket.
