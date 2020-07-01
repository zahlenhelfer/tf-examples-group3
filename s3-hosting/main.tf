provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = templatefile("bucket_policy.tpl", {
    bucket_name = var.bucket_name
  })
}

resource "aws_s3_bucket_object" "html_object" {
  bucket = var.bucket_name
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("index.html")

  depends_on = [
    aws_s3_bucket_policy.bucket_policy,
    aws_s3_bucket.bucket
  ]

}

resource "aws_route53_record" "public_dns" {
  zone_id = var.route53_zone_id
  name    = var.bucket_name
  type    = "A"
  alias {
    name                   = aws_s3_bucket.bucket.website_domain
    zone_id                = aws_s3_bucket.bucket.hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [
    aws_s3_bucket.bucket
  ]

}