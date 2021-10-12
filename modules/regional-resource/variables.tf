#variable "aws_provider" {
#    default = ""
#}

variable "rest_api_id" {
    default = ""
}

variable "rest_api_stage_name" {
    default = ""
}

variable "invoke_url" {
    default = ""
}

#variable "creds_store" {
#  description = "If this is not `dynamo` the IdP will use the Secrets Manager for authenication."
#  default     = "secrets"
#}

variable "s3_main_bucket_arn" {
    default = ""
}

variable "s3_main_bucket_name" {
    default = ""
}

variable "shared_repl_role_arn" {
    default = ""
}

variable "shared_repl_role_name" {
    default = ""
}

variable "shared_aws_iam_role_sftp_arn" {
    default = ""
}

variable "shared_aws_iam_role_sftp_log_arn" {
    default = ""
}
