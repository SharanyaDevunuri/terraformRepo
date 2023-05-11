# main.tf
provider "aws" {
  access_key = "AKIAXUALI3WZES645Q5R"
  secret_access_key = "9kFGbqx9T1oaAWnPztLIpBVZEG7kTzLLzjciIZlV"
  region = "us-east-1"
}
# Create a new EC2 instance using the EC2 module
module "example_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"

  name           = var.instance_name
  instance_type  = var.instance_type
  ami            = var.ami_id
  subnet_id      = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags = var.instance_tags
}

terraform {
backend "s3" {
bucket = "mytfstatefile3011"
key = "stateF/terraform.tfstate"
region = "us-east-1"
}
}
