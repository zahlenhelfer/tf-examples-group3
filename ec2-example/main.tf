resource "aws_instance" "webserver" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  count           = var.server_count
  security_groups = [aws_security_group.sg-webserver.name]
  user_data       = file("bootstrap.sh")

  tags = {
    Name    = "Server-${count.index + 1}"
    kst     = "4711"
    projekt = "Kundenportal"
  }
}

resource "aws_security_group_rule" "allow_webserver_access" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-webserver.id
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-webserver.id
}

resource "aws_security_group" "sg-webserver" {
  name = "Webserver Portfreigaben"
}
