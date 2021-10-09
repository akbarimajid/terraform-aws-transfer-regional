# role for SFTP server
resource "aws_iam_role" "sftp" {
  name = "sftp-server-iam-role"

  assume_role_policy = <<-POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
                "Service": "transfer.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }
        ]
    }
  POLICY
}

resource "aws_iam_role" "sftp_log" {
  # log role for SFTP server
  name = "sftp-server-iam-log-role"

  assume_role_policy = <<-POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
                "Service": "transfer.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }
        ]
    }
  POLICY
}

resource "aws_iam_role_policy" "sftp" {
  # policy to allow invocation of IdP API
  name = "sftp-server-iam-policy"
  role = aws_iam_role.sftp.id

  policy = <<-POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "InvokeApi",
          "Effect": "Allow",
          "Action": [
            "execute-api:Invoke"
          ],
          "Resource": "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${module.idp.rest_api_id}/${module.idp.rest_api_stage_name}/GET/*"
        },
        {
          "Sid": "ReadApi",
          "Effect": "Allow",
          "Action": [
            "apigateway:GET"
          ],
          "Resource": "*"
        }
      ]
    }
  POLICY
}

resource "aws_iam_role_policy" "sftp_log" {
  # policy to allow logging to Cloudwatch
  name = "sftp-server-iam-log-policy"
  role = aws_iam_role.sftp_log.id

  policy = <<-POLICY
    {
      "Version": "2012-10-17",
      "Statement": [{
          "Sid": "AllowFullAccesstoCloudWatchLogs",
          "Effect": "Allow",
          "Action": [
            "logs:*"
          ],
          "Resource": "*"
        }
      ]
    }
  POLICY
}

