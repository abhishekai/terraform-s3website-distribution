output "zone_id" {
  value       = "${data.aws_route53_zone.main.zone_id}"
  description = "The hosted zone id"
}

output "name_servers" {
  value       = "${data.aws_route53_zone.main.name_servers}"
  description = "A list of name servers in associated (or default) delegation set"
}