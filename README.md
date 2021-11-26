# Terraform AWS MWAA

Tutorial for Amazon Managed Workflows for Apache Airflow (MWAA) with Terraform. This is a word for word translation of the official [AWS quick start](https://docs.aws.amazon.com/mwaa/latest/userguide/quick-start.html) (with CloudFormation).

## Prerequisites
1. Install Terraform v1.0.10.
2. Export AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY. For eg.
```export AWS_ACCESS_KEY_ID=AKIAZ7D5S2Z74EXAMPLE
export AWS_SECRET_ACCESS_KEY=sDXlKg34f6bRFRqxP7AFGsLy6K19pEOa7example
```
3. Update the Terraform S3 backend in providers.tf.

## Variables

Below is an example `terraform.tfvars` file that you can use in your deployments:

```ini
region   = "ap-southeast-2"
prefix   = "airflow"
vpc_cidr = "10.192.0.0/16"
public_subnet_cidrs = [
  "10.192.10.0/24",
  "10.192.11.0/24"
]
private_subnet_cidrs = [
  "10.192.20.0/24",
  "10.192.21.0/24"
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
