# Provide input variable details which will be used in s3bucket creation.
variable "project_name" {}

variable "environment_name" {}

variable "bucket_name_as_domain_name" {
  type        = string
  description = "Name of the hosted zone"
}

variable "cdn_origin_identity_iam_arn" {}