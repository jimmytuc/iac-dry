dependencies {
  paths = ["../network", "../ssm-postgres", "../eks-cluster"]
}

include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

include "ssm" {
  path           = "../shared/ssm-parameters.hcl"
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
  cluster_identifier      = "${include.root.locals.environment}-postgres"
  engine_version          = "13.1"
  master_dbname           = "root"
  master_username         = "passwd"
  master_password         = dependency.ssm_parameters_postgres.outputs.value
  environment             = include.root.locals.environment
  vpc_id                  = dependency.network.outputs.vpc_id
  availability_zone       = include.root.locals.availability_zones[0]
  instance_class          = "db.t3.medium"
  backup_retention_period = 7
  parameter_group_family  = "postgres13"
  storage_type            = "gp2"
  allocated_storage       = 10
  max_allocated_storage   = 30
  apply_immediately       = true
  db_subnet_group_name    = dependency.network.outputs.database_subnet_group_name
  enabled_cloudwatch_logs_exports = true
  tags                    = include.root.locals.tags
  allow_security_group_ids = concat(
    [
      dependency.eks.outputs.worker_security_group_id,
      dependency.eks.outputs.cluster_security_group_id,
    ],
    include.root.locals.default_security_group_ids
  )
}

terraform {
  source = "../../..//modules/rds/postgres"
}
