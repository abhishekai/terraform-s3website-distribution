output "main_bucket_name" {
  description = "Main bucket name"
  value       = "${aws_s3_bucket.main.id}"
}

output "redirect_bucket_name" {
  description = "Redirect bucket endpoint"
  value       = "${aws_s3_bucket.redirect.id}"
}

output "main_bucket_domain_name" {
  description = "Main bucket site name"
  value       = "${aws_s3_bucket.main.bucket_domain_name}"
}

output "redirect_bucket_domain_name" {
  description = "Redirect bucket site name"
  value       = "${aws_s3_bucket.redirect.bucket_domain_name}"
}


/*
output "main_bucket" {
  description = "Main bucket endpoint"
  value       = "${aws_s3_bucket.main.website_endpoint}"
}

output "redirect_bucket" {
  description = "Redirect bucket endpoint"
  value       = "${aws_s3_bucket.redirect.website_endpoint}"
}

output "main_bucket_regional_domain_name" {
  description = "main bucket endpoint"
  value       = "${aws_s3_bucket.main.bucket_regional_domain_name}"
}

output "redirect_bucket_regional_domain_name" {
  description = "Redirect bucket endpoint"
  value       = "${aws_s3_bucket.redirect.bucket_regional_domain_name}"
}
*/
