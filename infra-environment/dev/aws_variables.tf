# Provide input variables which needs to be used in terrafom resource creation
variable "project_name" {
  description = "Name of the project."
}

variable "aws_region" {
  description = "The AWS region to create resources in."
  default = "us-east-1"
}

variable "domain" {
  description = "The domain name Route53 zone is going to be created with, and where we host our site. This must be the naked domain, e.g. `example.com`"
}

variable "product_domain" {
  type        = string
  description = "Product domain abbreviation of Route 53 zone"
}

variable "aws_access_key" {
  description = "The AWS access key."
}

variable "aws_secret_key" {
  description = "The AWS secret key."
}

variable "environment" {
  description = "The environment name to tag to the resources"
}
variable "acm_certificate_arn" {
 description = "The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. The ACM certificate must be in US-EAST-1."
}
