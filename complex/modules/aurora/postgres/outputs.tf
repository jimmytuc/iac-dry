output "host" {
  value = aws_rds_cluster_instance.cluster_instances.*.endpoint
}
output "arn" {
  value = aws_rds_cluster_instance.cluster_instances.*.arn
}
