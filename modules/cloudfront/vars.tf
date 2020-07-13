# Provide input variable details which will be used in cloudfront distribution creation.
variable "project_name" {}
variable "environment_name" {}

variable "domain_name" {
  type        = string
  description = "domain name like xyz.com"
}

variable "acm_certificate_arn" {
  description = "The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. The ACM certificate must be in US-EAST-1."
}


variable "s3_bucket_main_name" {}

variable "s3_bucket_redirect_name" {}

variable "s3_bucket_main_domain_name" {}

variable "s3_bucket_redirect_domain_name" {}

variable "waf_web_acl_id" {}
/*
variable "bucket_main_website_endpoint" {
  description = "endpoint of s3 main bucket"
}

variable "bucket_redirect_website_endpoint" {
  description = "endpoint of s3 redirect bucket"
}

variable "main_bucket_regional_domain_name" {
  description = "regional domain name of s3 main bucket"
}
variable "redirect_bucket_regional_domain_name" {
  description = "regional domain name of s3 redirect bucket"
}*/
