# terraform-aws-transfer

This is a Terraform module to create a custom identity provider for the AWS Transfer for SFTP service.

This module aims to set up an identity provider built on:
* API Gateway
* Lambda
* AWS Secrets
* Route53 latency-based- routing

This module will output the URL for the API Gateway which should be used as the ***url*** argument for the ***aws_transfer_server*** resource

## Credential Store

The credentials can be stored as AWS Secrets.

The infrastructure code is based on the example provided (in the CF template) in the AWS Storage Blog article
https://aws.amazon.com/blogs/storage/enable-password-authentication-for-aws-transfer-for-sftp-using-aws-secrets-manager/.


Also for minimizing network latency with your AWS Transfer for SFTP servers we used the solution in AWS Storage Blog article
https://aws.amazon.com/blogs/storage/minimize-network-latency-with-your-aws-transfer-for-sftp-servers/
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| creds_store | The creds store that will be used for authentication<br>Valid should be: **secrets** | string | secrets | yes |

## Outputs

| Name | Description |
|------|-------------|
| invoke_url | The URL which the SFTP service will use to send authentication requests to |

## Usage
```hcl-terraform
terraform init
terraform plan
terraform apply
```

## Terraform Versions

This module supports Terraform v1.0.
