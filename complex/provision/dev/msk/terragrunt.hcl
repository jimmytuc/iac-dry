dependencies {
  paths = ["../network"]
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

include "eks" {
  path           = "../shared/eks-cluster.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  name        = "${include.root.locals.environment}"
  env = include.root.locals.environment
  subnets = dependency.network.outputs.private_subnets
  vpc_id = dependency.network.outputs.vpc_id
  node_count = 3

  allowed_security_groups = concat(
    [
      dependency.eks.outputs.worker_security_group_id,
      dependency.eks.outputs.cluster_security_group_id,
    ],
    include.root.locals.default_security_group_ids
  )

  tags = merge(include.root.locals.tags, {
    Name = "app-kafka"
  })
}

terraform {
  source = "../../..//modules/msk"
}
