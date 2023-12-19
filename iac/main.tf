provider "aws" {
  region = "eu-central-1"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = "t2.nano"
}

resource "aws_security_group" "allow_all_traffic" {
  name        = "allow_all_traffic"
  description = "Allows worldwide traffic"

  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "Traffic from worldwide"
    cidr_blocks = [var.cidr]
    protocol    = "-1" # Equivalent to ALL protocols
    from_port   = "0"
    to_port     = "0" # Equivalent to 65535
  }

  egress {
    description = "Traffic to worldwide"
    cidr_blocks = [var.cidr]
    protocol    = "-1" # Equivalent to ALL protocols
    from_port   = "0"
    to_port     = "0" # Equivalent to 65535
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "s3-bucket-asoikhfkjseriugerwihefgefoiuefoi"
}

resource "aws_vpc_endpoint" "gateway_endpoint_for_s3" {
  vpc_id       = data.aws_vpc.default.id
  service_name = "com.amazonaws.eu-central-1.s3"
}