output "endpoint" {
  value = aws_transfer_server.sftp.endpoint
}

output "role" {
  value = aws_iam_role.foo.arn
}

output "SFTP-global-domain" {
  value = aws_route53_record.route53_record.fqdn
}

output "region-bucket-name" {
  value = aws_s3_bucket.sftp.id
}