#Terraform definition file - this file describes the minimum required infrastructure for the project kickoff.

## Setup AWS provide
provider "aws" {
  #Avoid using keys if possible, either go for aws vault to set up local machine with AWS or use aws credentials file
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}

module "public_route53_hosted_zone" {
  source         = "../../modules/route53"
  domain_name    = var.domain
  product_domain = var.product_domain
  environment    = var.environment
  cdn_domain_name = "${module.cloudfront_distribution.cdn_domain_name}"
  cdn_hosted_zone_id = "${module.cloudfront_distribution.cdn_hosted_zone_id}"
}

module "s3_buckets" {
  source         = "../../modules/s3"
  bucket_name_as_domain_name    = var.domain
  project_name = var.project_name
  environment_name = var.environment
  cdn_origin_identity_iam_arn = "${module.cloudfront_distribution.cdn_origin_access_identity_arn}"
}


module "cloudfront_distribution" {
  source              = "../../modules/cloudfront"
  domain_name         = var.domain
  project_name        = var.project_name
  environment_name    = var.environment
  acm_certificate_arn = var.acm_certificate_arn
  s3_bucket_main_name = "${module.s3_buckets.main_bucket_name}"
  s3_bucket_redirect_name = "${module.s3_buckets.redirect_bucket_name}"
  s3_bucket_main_domain_name = "${module.s3_buckets.main_bucket_domain_name}"
  s3_bucket_redirect_domain_name = "${module.s3_buckets.redirect_bucket_domain_name}"
  waf_web_acl_id                = "${module.waf_ip_range_acl.waf_web_acl_id}"
}

module "waf_ip_range_acl"{
  source              = "../../modules/waf"
  project_name        = var.project_name
  environment_name    = var.environment
  cf_waf_rule_name    = "MyIpRange"
  cf_waf_acl_name     = "SecureCDN"
  ip_type             = "IPV4"
}
