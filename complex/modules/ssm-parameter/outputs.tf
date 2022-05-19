output "value" {
  sensitive = true
  value = aws_ssm_parameter.main.value
}
