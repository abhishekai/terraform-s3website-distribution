# Provide input variable details which will be used in route53 creation.
variable "domain_name" {
  type        = string
  description = "Name of the hosted zone"
}

variable "product_domain" {
  type        = string
  description = "Product domain abbreviation of Route 53 zone"
}

variable "environment" {
  type        = string
  description = "Environment this Route 53 zone belongs to"
}

variable "cdn_domain_name" {
  description = "domain name of cloudfront distribution"
}

variable "cdn_hosted_zone_id" {
  description = "hosted zone id for cloudfront distribution"
}