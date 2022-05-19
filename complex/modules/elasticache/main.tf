resource "aws_elasticache_cluster" "cluster" {
  cluster_id           = var.cluster_name
  engine               = "redis"
  node_type            = var.instance_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  #engine_version       = "6.x"
  port              = 6379
  subnet_group_name = aws_elasticache_subnet_group.elasticache_subnets.name
}

resource "aws_elasticache_subnet_group" "elasticache_subnets" {
  name       = "${var.cluster_name}-subnet"
  subnet_ids = var.elasticache_subnets
}
