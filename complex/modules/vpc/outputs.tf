output "cluster_name" {
  value = var.cluster_name
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group
}

output "elasticache_subnets" {
  value = module.vpc.elasticache_subnets
}

output "intra_subnets" {
  value = module.vpc.intra_subnets
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
