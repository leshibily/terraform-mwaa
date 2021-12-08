# Common

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