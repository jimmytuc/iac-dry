include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "../../..//modules/ssm-parameter"
}

inputs = {
  aws_ssm = "/${include.root.locals.environment}/mysql/password"
  environment = include.root.locals.environment
  app_name = "mysql"
  tags = {
    owner = "terragrunt-provisioner"
  }
}
