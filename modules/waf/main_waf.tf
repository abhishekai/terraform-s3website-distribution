## Provide definition of each resources required to create WAF acl.
## Name - Module WAF Classic (Web Application Firewall)

locals {
  cf_waf_rule = var.cf_waf_rule_name
  cf_waf_acl  = var.cf_waf_acl_name
  ip_type     = var.ip_type
}


resource "aws_waf_ipset" "ipset" {
  name = "WhitelistedIps"

  dynamic "ip_set_descriptors" {

    for_each = ["191.128.1.0/24", "10.10.2.0/24"]

    content {
      type  = local.ip_type
      value = ip_set_descriptors.value
    }
  }
}

resource "aws_waf_rule" "wafrule" {
  depends_on  = ["aws_waf_ipset.ipset"]

  name        = local.cf_waf_rule
  metric_name = local.cf_waf_rule

  predicates {
    data_id = aws_waf_ipset.ipset.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "waf_acl" {
  depends_on  = ["aws_waf_ipset.ipset", "aws_waf_rule.wafrule"]

  name        = local.cf_waf_acl
  metric_name = local.cf_waf_acl

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.wafrule.id
    type     = "REGULAR"
  }
}