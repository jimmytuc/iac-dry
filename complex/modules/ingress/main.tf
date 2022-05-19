resource "helm_release" "ingress_gateway" {
  name       = var.ingress_gateway_name
  chart      = var.ingress_gateway_chart_name
  repository = var.ingress_gateway_chart_repo
  version    = var.ingress_gateway_chart_version
  namespace  = "kube-system"

  dynamic "set" {
    for_each = var.ingress_gateway_annotations

    content {
      name  = set.key
      value = set.value
      type  = "string"
    }
  }
}
