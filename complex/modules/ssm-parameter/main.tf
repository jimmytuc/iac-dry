resource "random_password" "main" {
  length  = var.password_length
  special = var.allow_special_chars
}

resource "aws_ssm_parameter" "main" {
  name        = var.aws_ssm
  description = var.aws_ssm
  type        = "SecureString"
  value       = random_password.main.result
  overwrite   = true # for redeploying

  tags = merge({
    environment = var.environment
    app         = var.app_name
  }, var.tags)
}
