include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "../../..//modules/vpc"
}

inputs = {
  cluster_name               = include.root.locals.name
  name_prefix                = include.root.locals.name
  cidr                       = include.root.locals.network_cidr
  subnet_prefix_extension    = 5
  zone_offset                = 5
  exclude_availability_zones = [
    "${include.root.locals.region}c"
  ]
  iac_environment_tag        = include.root.locals.environment
}
