data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

provider "aws" {
  alias  = "euw1"
  region = "eu-west-1"
}

provider "aws" {
  alias  = "use2"
  region = "us-east-2"
}

module "idp" {
  source = "./modules/api-gateway"

  creds_store = "secrets"
}


module "eu-west-1_modules" {
  source = "./modules/regional-resource/public-secrets"
  
  providers = {
    aws = aws.euw1
  }
  #rest_api_id = module.idp.rest_api_id
  #rest_api_stage_name = module.idp.rest_api_stage_name
  invoke_url = module.idp.invoke_url
  s3_main_bucket_arn  = aws_s3_bucket.main-sftp-bucket.arn
  s3_main_bucket_name = aws_s3_bucket.main-sftp-bucket.id
  shared_repl_role_arn = aws_iam_role.my-replication-role.arn
  shared_repl_role_name = aws_iam_role.my-replication-role.name
  shared_aws_iam_role_sftp_arn = aws_iam_role.sftp.arn
  shared_aws_iam_role_sftp_log_arn = aws_iam_role.sftp_log.arn
}

module "us-east-2_modules" {
  source = "./modules/regional-resource/public-secrets"
  
  providers = {
    aws = aws.use2
  }
  #rest_api_id = module.idp.rest_api_id
  #rest_api_stage_name = module.idp.rest_api_stage_name
  invoke_url = module.idp.invoke_url
  s3_main_bucket_arn  = aws_s3_bucket.main-sftp-bucket.arn
  s3_main_bucket_name = aws_s3_bucket.main-sftp-bucket.id
  shared_repl_role_arn = aws_iam_role.my-replication-role.arn
  shared_repl_role_name = aws_iam_role.my-replication-role.name
  shared_aws_iam_role_sftp_arn = aws_iam_role.sftp.arn
  shared_aws_iam_role_sftp_log_arn = aws_iam_role.sftp_log.arn
}


