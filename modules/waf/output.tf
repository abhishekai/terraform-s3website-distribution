
output "waf_web_acl_id" {
  description = "The ID of the WAF WebACL."
  value       = "${aws_waf_web_acl.waf_acl.id}"
}

output "waf_web_acl_arn" {
  description = "The ARN of the WAF WebACL."
  value       = "${aws_waf_web_acl.waf_acl.arn}"
}