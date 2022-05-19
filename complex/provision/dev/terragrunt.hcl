locals {
  environment = "uat"
  region = "us-east-1"
  name = "app-${local.environment}"
  availability_zones = ["us-east-1a"]
  network_cidr = "10.1.0.0/16"
  k8s = {
    app_name = "${local.name}-cluster"
    k8s_admin_users = []
    k8s_developer_users = []
    asg_instance_types = ["t3a.medium"]
  }
  tags = {
    Environment = local.environment
    Owner = "terraform-provisioner"
    Application = "application"
  }
  default_security_group_ids = [
    // any whitelist sg
  ]
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    variable "provider_default_tags" {
      type = map
      default = {}
    }
    provider "aws" {
      region = "${local.region}"
      default_tags {
        tags = var.provider_default_tags
      }
    }
    data "aws_default_tags" "current" {}
  EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend-config.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "<<app.s3.bucket>>"
    key            = "state/uat/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
#    dynamodb_table = "terraform_state_lock"
  }
}

skip                          = true
terragrunt_version_constraint = ">= 0.34"
terraform_version_constraint  = ">= 1.1.2"
