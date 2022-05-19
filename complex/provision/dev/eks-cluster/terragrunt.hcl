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

inputs = {
  env                                      = include.root.locals.environment
  vpc_id                                   = dependency.network.outputs.vpc_id
  cluster_name                             = dependency.network.outputs.cluster_name
  public_subnets                           = dependency.network.outputs.public_subnets
  private_subnets                          = dependency.network.outputs.private_subnets
  kubernetes_version                       = "1.21"
  admin_users                              = include.root.locals.k8s.k8s_admin_users
  developer_users                          = include.root.locals.k8s.k8s_developer_users
  name_prefix                              = include.root.locals.k8s.app_name
  asg_instance_types                       = include.root.locals.k8s.asg_instance_types
  autoscaling_minimum_size_by_az           = 5
  autoscaling_maximum_size_by_az           = 10
  autoscaling_average_cpu                  = 30
  spot_termination_handler_chart_name      = "aws-node-termination-handler"
  spot_termination_handler_chart_repo      = "https://aws.github.io/eks-charts"
  spot_termination_handler_chart_version   = "0.13.3"
  spot_termination_handler_chart_namespace = "kube-system"
}

terraform {
  source = "../../..//modules/eks"
}
