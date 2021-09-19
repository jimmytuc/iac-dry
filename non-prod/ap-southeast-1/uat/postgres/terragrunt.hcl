locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "${path_relative_from_include()}/modules//postgres"
}

inputs = {
  name           = "postgres-${local.env}"
  instance_class = "db.t3a.micro"

  allocated_storage = 20
  storage_type      = "standard"

  master_username = "admin"
  # TODO: To avoid storing your DB password in the code, set it as the environment variable TF_VAR_master_password
}
