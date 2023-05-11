variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID"
}

variable "subnet_id" {
  description = "ID of the subnet"
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "instance_tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
}