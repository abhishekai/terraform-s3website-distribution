output "cdn_domain_name" {
  description = "Cloudfront distrinbution domain name"
  value       = "${aws_cloudfront_distribution.cloudfront_distribution.*.domain_name}"
}

output "cdn_hosted_zone_id" {
  description = "Cloudfront distrinbution domain name"
  value       = "${aws_cloudfront_distribution.cloudfront_distribution.*.hosted_zone_id}"
}

output "cdn_origin_access_identity_arn" {
  value = "${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"
}