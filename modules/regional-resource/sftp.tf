data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_transfer_server" "sftp" {
  identity_provider_type = "API_GATEWAY"
  logging_role           = var.shared_aws_iam_role_sftp_log_arn
  url                    = var.invoke_url # url from output of the module
  invocation_role        = var.shared_aws_iam_role_sftp_arn
  endpoint_type          = "PUBLIC"

  tags = {
    owner = "majid"
    NAME = "${data.aws_region.current.name}-sftp-server"
  }
}
