## Provide definition of each resources required to create route53.
## Name - Module route53
locals {
  description = "Public zone for ${var.name}"
}

resource "aws_route53_zone" "main" {
  name              = var.name
  comment           = local.description

  tags = {
    "Name"          = var.name
    "ProductDomain" = var.product_domain
    "Environment"   = var.environment
    "Description"   = local.description
  }
}