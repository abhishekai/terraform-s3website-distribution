# terraform-s3website-distribution

This terraform module creates a required resources to distribute static contents from s3 bucket and deliver via CloudFront.

Following services will be used to complete this exercise.
- S3
- Route53
- AWS Certificate Manager
- CloudFront
- WAF

# Requirements
create `terraform.tfvars` with following values:
```
project_key         = "terraform-s3website-distribution"
aws_access_key      = "XXXXXXXXXX"
aws_secret_key      = "XXXXXXXXXX"
aws_region          = "us-east-1"
```

# Included features:
* Take the ARN of an ACM certificate as a parameter.
* Create the necessary S3 bucket with best practices configuration.
* Create route53 HostedZone.
* Create CloudFront web distribution.
* Create relevant DNS entries pointing to the distribution.
* IP protection implemented as desired.

## Getting Started:
	terraform init
	terraform plan
	terraform apply
