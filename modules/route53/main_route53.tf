## Provide definition of each resources required to create route53.
## Name - Module route53
locals {
  description = "Public zone for ${var.domain_name}"
  www_domain = "www.${var.domain_name}"

  domains = [
    "${var.domain_name}",
    "${local.www_domain}"
  ]
}
# Note: Creating this route53 zone is not enough. The domain's name servers need to point to the NS servers of the route53 zone. Otherwise the DNS lookup will fail.
resource "aws_route53_zone" "main" {
  name              = var.domain_name
  comment           = local.description

  tags = {
    "Name"          = var.domain_name
    "ProductDomain" = var.product_domain
    "Environment"   = var.environment
    "Description"   = local.description
  }
}

/*data "aws_route53_zone" "main" {
  name = var.domain_name
}*/

resource "aws_route53_record" "A" {
  count   = "${length(local.domains)}"
  zone_id =  aws_route53_zone.main.zone_id
  name    = "${element(local.domains, count.index)}"
  type    = "A"

  alias {
    name                   = "${element(var.cdn_domain_name, count.index)}"
    zone_id                = "${element(var.cdn_hosted_zone_id, count.index)}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "AAAA" {
  count   = "${length(local.domains)}"
  zone_id =  aws_route53_zone.main.zone_id
  name    = "${element(local.domains, count.index)}"
  type    = "AAAA"

  alias {
    name                   = "${element(var.cdn_domain_name, count.index)}"
    zone_id                = "${element(var.cdn_hosted_zone_id, count.index)}"
    evaluate_target_health = false
  }
}