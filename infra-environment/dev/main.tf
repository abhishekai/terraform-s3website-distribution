#Terraform definition file - this file describes the minimum required infrastructure for the project kickoff.

## Setup AWS provide
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}

module "public_route53_hosted_zone" {
  source         = "../../modules/route53"
  name           = var.domain
  product_domain = var.product_domain
  environment    = var.environment
}