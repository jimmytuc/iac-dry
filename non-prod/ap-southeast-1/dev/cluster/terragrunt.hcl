locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
}

terraform {
  source = "${path_relative_from_include()}/modules//asg-elb-service"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  vpc_id         = dependency.vpc.outputs.vpc_id
  name          = "cluster-${local.env}"
  instance_type = "t3a.micro"

  min_size = 1
  max_size = 2

  server_port = 8080
  elb_port    = 80
}
