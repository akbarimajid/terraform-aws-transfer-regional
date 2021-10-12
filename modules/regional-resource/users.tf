module "secrets-manager" {

  source = "lgallard/secrets-manager/aws"

  secrets = {
    "SFTP/user-111" = {
      description             = "My secret 1"
      secret_string           = <<-EOF
    {
      "HomeDirectoryDetails": "[{\"Entry\": \"/\", \"Target\": \"/${aws_s3_bucket.sftp.id}/$${Transfer:UserName}\"}]",
      "Password": "dfgOB#$66544FFYYY@33",
      "Role": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${data.aws_region.current.name}-transfer-user-iam-role",
      "UserId": "user-111"
    }
  EOF
    },
    "SFTP/user-222" = {
      description             = "My secret 2"
      secret_string           = <<-EOF
    {
      "HomeDirectoryDetails": "[{\"Entry\": \"/\", \"Target\": \"/${aws_s3_bucket.sftp.id}/$${Transfer:UserName}\"}]",
      "Password": "SFbbn$$6677KKlSSdf#4",
      "Role": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${data.aws_region.current.name}-transfer-user-iam-role",
      "UserId": "user-222"
    }
  EOF
    }
  }

  tags = {
    owner       = "majid"
    Terraform   = true

  }
}
