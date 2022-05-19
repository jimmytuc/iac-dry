skip = true

dependency "ssm_parameters_mysql" {
  config_path = "${get_original_terragrunt_dir()}/../ssm-mysql"
  mock_outputs = {
    value = "ssm-value"
  }
}

dependency "ssm_parameters_postgres" {
  config_path = "${get_original_terragrunt_dir()}/../ssm-postgres"
  mock_outputs = {
    value = "ssm-value"
  }
}
