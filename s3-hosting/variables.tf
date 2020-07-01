variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "route53_zone_id" {
  type    = string
  default = "Z1HBBO00A4RW4K"
}

variable "bucket_name" {
  type    = string
  default = "s3test.awslabs.cf"
}

variable "bucket_arn" {
  type    = string
  default = "arn:aws:s3:::s3test.awslabs.cf/*"
}
