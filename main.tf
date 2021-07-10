provider "aws" {
  region = "eu-central-1"
}
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}
output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the web server"
}

resource "aws_instance" "example" {
    ami           = "ami-00f22f6155d6d92c5"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    user_data = <<-EOF
              #!/bin/bash
              sudo su
              yum update -y
              yum install httpd -y
              cd /var/www/html
              echo "Hello, World" > index.html
              service httpd start
              EOF
    tags = {
    Name = "My-webserver"
  }
}