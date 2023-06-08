variable "region" {}
variable "ami" {}
variable "instance_type" {}
variable "tags" {}

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}
terraform {
  backend "s3" {
  }
}
provider "aws" {
    region = var.region
}
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "${var.tags}-vpc"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.tags}-vpc-IG"
  }
}
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.tags}-subnet"
  }
}
# Public subnets route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name        = "${var.tags}-public-route-table"
  }
}
resource "aws_route" "primary-internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.public.id
}
resource "aws_security_group" "sg" {
  name        = "${var.tags}-SG"
  vpc_id      = aws_vpc.my_vpc.id
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "tls_private_key" "demo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "key_pair" {
  key_name   = "${var.tags}-key-pair"
  public_key = tls_private_key.demo_key.public_key_openssh
}
resource "local_file" "local_key_pair" {
  filename = "${aws_key_pair.key_pair.id}.pem"
  file_permission = "0400"
  content = tls_private_key.demo_key.private_key_pem
}
resource "aws_instance" "EC2Instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.key_pair.id
    subnet_id = aws_subnet.my_subnet.id
    vpc_security_group_ids = [
        aws_security_group.sg.id
    ]
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
    }
    tags = {
        Name = var.tags
    }
}
