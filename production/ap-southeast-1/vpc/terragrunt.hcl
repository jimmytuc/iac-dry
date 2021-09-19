terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=3.5.0"
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "ap-southeast-1"
}
EOF
}

inputs = {
  name = "dev-vpc"
  cidr = "172.16.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets = ["172.16.1.0/24", 172.16.2.0/24", "172.16.3.0/24"]
  public_subnets  = ["172.16.101.0/24", "172.16.102.0/24", "172.16.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Name = "app-vpc"
    Terraform = "true"
    Environment = "production"
  }
}
