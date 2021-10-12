module "idp" {
  source = "./modules/api-gateway"
  
  creds_store = "secrets"
}

module "shared" {
  source = "./modules/shared-services"

  rest_api_id = module.idp.rest_api_id
  rest_api_stage_name = module.idp.rest_api_stage_name
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1" 
}

provider "aws" {
  alias  = "eu-west-2"
  region = "eu-west-2"
}

module "us-east-1" {
  source = "./modules/regional-resource"
  providers = {
    aws = aws.us-east-1
  }

  invoke_url = module.idp.invoke_url
  s3_main_bucket_arn  = module.shared.s3_main_bucket_arn
  s3_main_bucket_name = module.shared.s3_main_bucket_id
  shared_repl_role_arn = module.shared.shared_repl_role_arn
  shared_repl_role_name = module.shared.shared_repl_role_name
  shared_aws_iam_role_sftp_arn = module.shared.shared_aws_iam_role_sftp_arn
  shared_aws_iam_role_sftp_log_arn = module.shared.shared_aws_iam_role_sftp_log_arn
}
module "eu-west-1" {
  source = "./modules/regional-resource"
  providers = {
    aws = aws.eu-west-2
  }

  invoke_url = module.idp.invoke_url
  s3_main_bucket_arn  = module.shared.s3_main_bucket_arn
  s3_main_bucket_name = module.shared.s3_main_bucket_id
  shared_repl_role_arn = module.shared.shared_repl_role_arn
  shared_repl_role_name = module.shared.shared_repl_role_name
  shared_aws_iam_role_sftp_arn = module.shared.shared_aws_iam_role_sftp_arn
  shared_aws_iam_role_sftp_log_arn = module.shared.shared_aws_iam_role_sftp_log_arn
}