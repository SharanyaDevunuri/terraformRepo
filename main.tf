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
    availability_zone = "us-west-1a"
    tenancy = "default"
    subnet_id = "subnet-08efe5ab8f2f984de"
    ebs_optimized = false
    vpc_security_group_ids = [
        "sg-0536a0a608be74879"
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
