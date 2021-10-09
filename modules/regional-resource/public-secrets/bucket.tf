resource "aws_iam_policy" "my-replication-policy" {
  name = "${data.aws_region.current.name}-my-replication-policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.sftp.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.sftp.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "${var.s3_main_bucket_arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "replication" {
  name       = "${data.aws_region.current.name}-tf-iam-role-attachment-replication-12345"
  roles      = ["${var.shared_repl_role_name}"]
  policy_arn = "${aws_iam_policy.my-replication-policy.arn}"
}

resource "aws_s3_bucket" "sftp" {
  bucket_prefix = "${data.aws_region.current.name}-sftpbucket"
  acl           = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  replication_configuration {
    role = "${var.shared_repl_role_arn}"

    rules {
      prefix = ""
      status = "Enabled"

      destination {
        bucket        = "${var.s3_main_bucket_arn}"
        storage_class = "STANDARD"
      }
    }
  }

  tags = {
    Name       = "${data.aws_region.current.name}-cutomer-sftp-bucket"
    owner      = "majid"
  }
}

resource "aws_s3_bucket_public_access_block" "sftp-bucket_access" {
  bucket = aws_s3_bucket.sftp.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}