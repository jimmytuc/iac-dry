dependencies {
  paths = ["../eks-cluster"]
}

include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  ingress_gateway_name          = "dev"
  ingress_gateway_chart_name    = "nginx-ingress"
  ingress_gateway_chart_repo    = "https://helm.nginx.com/stable"
  ingress_gateway_chart_version = "0.13.0"
  ingress_gateway_annotations = {
    "controller.name"                                                                                           = "dev"
    "controller.ingressClass"                                                                                   = "dev"
    "controller.enableSnippets"                                                                                 = true
    "controller.service.httpPort.targetPort"                                                                    = "http",
    "controller.service.httpsPort.targetPort"                                                                   = "http",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"        = "http",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"               = "https",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-connection-idle-timeout" = "60",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"                    = "nlb",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"                = "arn:aws:acm:ap-southeast-1:xxxxxxxxx:certificate/xxxx-xxxx-xxx-xxxxx-xxxxxxxxx"
  }
}

generate "provider-local" {
  path      = "provider-local.tf"
  if_exists = "overwrite"
  contents  = file("../providers/k8s.tf")
}

terraform {
  source = "../../..//modules/ingress"
}
