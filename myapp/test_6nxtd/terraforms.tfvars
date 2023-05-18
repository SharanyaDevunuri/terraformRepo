instance_name = "siri"
instance_type = "t3.2xlarge"
ami_id = "Image ID: ami-0d09e058a2a630df6 OS: bottlerocket-aws-k8s-1.23-nvidia-x86_64-v1.14.0-9cd59298"
subnet_id = "us-west-2"
security_group_ids = ["sg-0cd060c8df19420a8"]

instance_tags = {
  Environment = "production"
}