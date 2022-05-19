# Deploy external dns to manage dns configurations
resource "helm_release" "external_dns" {
  name       = var.name
  chart      = var.external_dns_chart_name
  repository = var.external_dns_chart_repo
  version    = var.external_dns_chart_version
  namespace  = "kube-system"

  set {
    name  = "domainFilters"
    value = "{${var.domains}}"
  }

  values = [
    var.extra_values
  ]

  set {
    name  = "txtOwnerId"
    value = var.owner_id
  }
}
