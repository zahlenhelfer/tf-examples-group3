variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 Instance"
  default     = "ami-0a02ee601d742e89f"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "server_count" {
  type    = number
  default = 2
}