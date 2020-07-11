variable "name" {
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
