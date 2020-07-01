variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "db_instance_type" {
  type    = string
  default = "db.t2.micro"
}

variable "db_name" {
  type    = string
  default = "mydb"
}

variable "db_user" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type    = string
  default = "Geheim12345"
}