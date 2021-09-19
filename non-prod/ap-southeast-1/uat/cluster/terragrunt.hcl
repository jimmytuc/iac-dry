locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
}

terraform {
  source = "${path_relative_from_include()}/modules//asg-elb-service"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  vpc_id        = dependency.vpc.outputs.vpc_id
  name          = "cluster-${local.env}"
  instance_type = "t3a.micro"

  min_size = 2
  max_size = 2

  server_port = 8080
  elb_port    = 80
}
