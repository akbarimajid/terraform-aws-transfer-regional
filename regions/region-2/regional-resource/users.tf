module "secrets-manager" {

  source = "lgallard/secrets-manager/aws"

  secrets = {
    "SFTP/user-1" = {
      description             = "My secret 1"
      secret_string           = <<-EOF
    {
      "HomeDirectoryDetails": "[{\"Entry\": \"/\", \"Target\": \"/${aws_s3_bucket.sftp.id}/$${Transfer:UserName}\"}]",
      "Password": "",
      "Role": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${data.aws_region.current.name}-transfer-user-iam-role",
      "UserId": "user-1"
    }
  EOF
    },
    "SFTP/user-2" = {
      description             = "My secret 2"
      secret_string           = <<-EOF
    {
      "HomeDirectoryDetails": "[{\"Entry\": \"/\", \"Target\": \"/${aws_s3_bucket.sftp.id}/$${Transfer:UserName}\"}]",
      "Password": "",
      "Role": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${data.aws_region.current.name}-transfer-user-iam-role",
      "UserId": "user-2"
    }
  EOF
    }
  }

  tags = {
    owner       = "majid"
    Terraform   = true

  }
}
