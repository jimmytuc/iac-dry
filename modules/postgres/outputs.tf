output "endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "db_name" {
  value = aws_db_instance.postgres.name
}

output "arn" {
  value = aws_db_instance.postgres.arn
}
