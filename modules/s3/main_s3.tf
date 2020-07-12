## Provide definition of each resources required to create s3.
## Name - Module s3

locals {
  www_domain = "www.${var.bucket_name_as_domain_name}"
}

# Note: The bucket name needs to carry the same name as the domain!
# Creates bucket to store the static website
resource "aws_s3_bucket" "main" {
  bucket = local.www_domain
  acl    = "private"
  website {
    index_document = "index.html"
    error_document = "404.html"
  }
  tags = {
    Name = "${format("%s-%s", var.project_name, var.environment_name)}"
  }
}

#Creates bucket for the website handling the redirection (if required), e.g. from https://www.example.com to https://example.com
resource "aws_s3_bucket" "redirect" {
  bucket = "${var.bucket_name_as_domain_name}"
  acl    = "private"
  website {
    redirect_all_requests_to = aws_s3_bucket.main.id
  }
  tags = {
    Name = "${format("%s-%s", var.project_name, var.environment_name)}"
  }

}

# Creates policy to limit access to the S3 bucket to CloudFront Origin
resource "aws_s3_bucket_policy" "update_main_bucket_policy" {
  bucket = aws_s3_bucket.main.id
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Sid": "AllowCloudFrontOriginAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.cdn_origin_identity_iam_arn}"
      },
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "${aws_s3_bucket.main.arn}/*",
        "${aws_s3_bucket.main.arn}"
      ]
    }
  ]
}
POLICY
}

