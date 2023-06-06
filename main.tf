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

provider "aws" {
    region = var.region
}

terraform {
  backend "s3" {
  }
}
resource "aws_instance" "EC2Instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = "test-delete"
    availability_zone = "us-east-1d"
    tenancy = "default"
    subnet_id = "subnet-045a96461f4c2bd36"
    ebs_optimized = false
    vpc_security_group_ids = [
        "sg-01103824f39bbe40f"
    ]
    source_dest_check = true
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
    }
    tags = {
        Name = var.tags
    }
}
