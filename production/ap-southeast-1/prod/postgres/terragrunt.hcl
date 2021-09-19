locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
}

terraform {
  source = "${path_relative_from_include()}/modules//postgres"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name           = "mysql_${local.env}"
  instance_class = "db.t2.medium"

  allocated_storage = 100
  storage_type      = "standard"

  master_username = "admin"
  # TODO: To avoid storing your DB password in the code, set it as the environment variable TF_VAR_master_password
}
