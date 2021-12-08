# MWAA S3

resource "random_id" "id" {
  byte_length = 2
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.prefix}-${random_id.id.hex}"

  versioning {
    enabled = true
  }

  tags = merge(local.tags, {
    Name = "${var.prefix}-s3-bucket"
  })
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "dags" {
  for_each = fileset("dags/", "*.py")
  bucket   = aws_s3_bucket.s3_bucket.id
  key      = "dags/${each.value}"
  source   = "dags/${each.value}"
  etag     = filemd5("dags/${each.value}")
}