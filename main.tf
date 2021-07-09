provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
    ami           = "ami-00f22f6155d6d92c5"
    instance_type = "t2.micro"
    tags = {
    Name = "Mallinath"
  }
}