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
    Name = var.prefix
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

# Access to push dags to S3

data "aws_iam_policy_document" "dags" {
  statement {
    sid = ""
    actions = [
      "s3:ListBucket",
      "s3:ListObjects*",
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.s3_bucket.arn,
    ]
  }

  statement {
    sid = ""
    actions = [
      "s3:PutObject*",
      "s3:DeleteObject*",
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/dags/*"
    ]
  }
}

resource "aws_iam_user" "dags" {
  name = var.prefix
}

resource "aws_iam_policy" "dags" {
  name   = "${var.prefix}-dags"
  path   = "/"
  policy = data.aws_iam_policy_document.dags.json
}

resource "aws_iam_policy_attachment" "dags" {
  name       = "${var.prefix}-dags"
  users      = [aws_iam_user.dags.name]
  policy_arn = aws_iam_policy.dags.arn
}

resource "aws_iam_access_key" "dags" {
  user = aws_iam_user.dags.name
}
