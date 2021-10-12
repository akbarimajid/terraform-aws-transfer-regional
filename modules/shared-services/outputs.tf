#output "invoke_url" {
#  value = module.idp.invoke_url
#}

output "s3_main_bucket_arn" {
  value = aws_s3_bucket.main-sftp-bucket.arn
}

output "s3_main_bucket_id" {
  value = aws_s3_bucket.main-sftp-bucket.id
}

output "shared_repl_role_arn" {
  value = aws_iam_role.my-replication-role.arn
}

output "shared_repl_role_name" {
  value = aws_iam_role.my-replication-role.name
}

output "shared_aws_iam_role_sftp_arn" {
  value = aws_iam_role.sftp.arn
}

output "shared_aws_iam_role_sftp_log_arn" {
  value = aws_iam_role.sftp_log.arn
}
