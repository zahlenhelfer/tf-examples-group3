provider "aws" {
  region = "eu-central-1"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 Instance"
  default     = "ami-0a02ee601d742e89f"
}

resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name    = "HelloWorld"
    kst     = "4711"
    projekt = "Kundenportal"
  }
}