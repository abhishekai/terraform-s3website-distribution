# Provide input variable details which will be used in web acl creation.
variable "project_name" {}

variable "environment_name" {}

variable "whitelisted_ips" {
  description = "List of sets of IP addresses to allow."
  type        = list
  default     = []
}

variable "cf_waf_rule_name" {}

variable "cf_waf_acl_name" {}

variable "ip_type" {}

/*
variable "cidr_range" {
  type = list
}*/
