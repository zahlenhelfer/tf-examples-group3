output "halloWelt" {
  value = "Hallo Welt"
}

output "dns_name" {
  value = aws_instance.webserver.*.public_dns
}