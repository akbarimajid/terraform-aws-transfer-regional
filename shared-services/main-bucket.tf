resource "aws_iam_role" "my-replication-role" {
  name = "my-replication-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY

  tags = {
    Terraform  = "true"
    owner      = "majid"
  }
}

resource "aws_s3_bucket" "main-sftp-bucket" {
  bucket_prefix = var.main_bucket_prefix
  acl           = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Terraform  = "true"
    Name       = var.main_bucket_prefix
    owner      = "majid"
  }
}

resource "aws_s3_bucket_public_access_block" "sftp-bucket_access" {
  bucket = aws_s3_bucket.main-sftp-bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

