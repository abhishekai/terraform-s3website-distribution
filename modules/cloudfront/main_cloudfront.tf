## Provide definition of each resources required to create cloudfront distributions.
## Name - Module cloudfront
locals {
  www_domain = "www.${var.domain_name}"
  waf_web_acl_id =  var.waf_web_acl_id

  domains = [
    "${var.domain_name}", # dataoncloud.tk
    "${local.www_domain}" # www.dataoncloud.tk
  ]

  s3_bucket_domain_names =[
    "${var.s3_bucket_redirect_domain_name}",
    "${var.s3_bucket_main_domain_name}"
  ]

  s3_bucket_names =[
    "${var.s3_bucket_redirect_name}", # dataoncloud.tk --redirect bucket
    "${var.s3_bucket_main_name}", # www.dataoncloud.tk --main bucket
  ]
  #Incase you need custom origin of cloufront for s3
 /* website_endpoints = [
    "${var.bucket_main_website_endpoint}",
    "${var.bucket_redirect_website_endpoint}"
  ]*/

  /*bucket_regional_domain_names = [
    "${var.main_bucket_regional_domain_name}",
    "${var.redirect_bucket_regional_domain_name}"
  ]*/
}

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  count               = "${length(local.domains)}" # loop through input domains
  enabled             = true
  default_root_object = "${element(local.domains, count.index) == local.www_domain ? "index.html" : ""}"
  aliases             = ["${element(local.domains, count.index)}"] #Route53 requires Alias/CNAME to be setup
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"  # The cheapest priceclass
  web_acl_id          = local.waf_web_acl_id
  origin {
    domain_name = "${element(local.s3_bucket_domain_names, count.index)}"
    origin_id   = "${element(local.s3_bucket_names, count.index)}"

    #Restrict to s3 signed url only
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }

    #Enable CustomOrigin incase you want to create S3oi
    /* custom_origin_config {
      http_port                = "80"
      https_port               = "443"
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }*/
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["DE", "IN", "GB", "US"]
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    #target_origin_id = "S3-${element(local.domains, count.index)}"
    target_origin_id = "${element(local.s3_bucket_names, count.index)}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    # default values..
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  #Don't get locked for 5 minutes when uploading something with the wrong ACL.
  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 300
  }
  # Don't cache 404's
  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/400.html"
    error_caching_min_ttl = 300
  }

  tags = {
    Name = "${format("%s-%s", var.project_name, var.environment_name)}"
  }
}

#Security module is added - OAI to
#An origin access identity is a CloudFront-specific account that allows CloudFront to access your restricted Amazon S3 objects
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin Access Identity for S3"
}

