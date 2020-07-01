provider "aws" {
  region  = "eu-central-1"
  profile = var.profile
}

terraform {
  backend "s3" {
    bucket = "zh-gruppe3-state"
    key    = "production.tfstate"
    region = "eu-central-1"
  }
}