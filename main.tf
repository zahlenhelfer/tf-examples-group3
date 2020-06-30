resource "aws_instance" "webserver" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  count           = var.server_count
  user_data       = <<-EOF
                    #!/bin/bash
                    yum install httpd -y
                    /sbin/chkconfig --levels 235 httpd on
                    service httpd start
                    instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
                    region=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
                    echo "<h1>$instanceId from $region</h1>" > /var/www/html/index.html
                    EOF
  security_groups = [aws_security_group.sg-webserver.name]

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

resource "aws_security_group" "sg-webserver" {
  name = "Webserver Portfreigaben"
  vpc_id = "vpc-6f4e9005"
}
