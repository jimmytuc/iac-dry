output "rds_mysql_pg_id" {
  value       = aws_db_parameter_group.rds_mysql_pg.id
  description = "ID of the RDS postgres parameter group"
}
output "rds_mysql_id" {
  value       = aws_db_instance.rds_mysql.id
  description = "ID of the of the RDS instance"
}
output "rds_security_group_ids" {
  value       = [aws_security_group.security_group_rds.id]
  description = "List of security group ids attached to the rds instance"
}
output "rds_hostname" {
  value = aws_db_instance.rds_mysql.address
}
output "rds_db_port" {
  value = aws_db_instance.rds_mysql.port
}
output "rds_username" {
  value = aws_db_instance.rds_mysql.username
}
output "rds_dbname" {
  value = aws_db_instance.rds_mysql.name
}
output "cloudwatch_logs_path" {
  value = (
  var.enabled_cloudwatch_logs_exports ?
  format("/aws/rds/instance/%s/mysql", aws_db_instance.rds_mysql.id)
  : ""
  )
}
