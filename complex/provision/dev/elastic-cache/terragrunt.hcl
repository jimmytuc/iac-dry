dependencies {
  paths = ["../network"]
}

locals {
  cache_instance_type = "cache.t2.medium"
}

include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

include "network" {
  path           = "../shared/network.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  cluster_name        = "${include.root.locals.environment}-mothership-cache"
  instance_type       = local.cache_instance_type
  elasticache_subnets = dependency.network.outputs.elasticache_subnets
}

terraform {
  source = "../../..//modules/elasticache"
}
