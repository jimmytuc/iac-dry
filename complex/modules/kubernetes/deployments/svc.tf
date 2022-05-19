resource "kubernetes_service" "main" {
  count = var.expose_service && var.set_k8s_service != null ? 1 : 0
  metadata {
    name = var.set_k8s_service.name
    namespace = var.app_namespace
    labels = {
      "app.kubernetes.io/name" = var.app_name
      "app.kubernetes.io/version" = var.app_version
      "app.kubernetes.io/part-of" = local.platform_app
    }
  }
  spec {
    dynamic "port" {
      for_each = var.set_k8s_service.ports
      content {
        name = lookup(port.value, "name", null)
        protocol = lookup(port.value, "protocol", "TCP")
        port = port.value.port
        target_port = lookup(port.value, "target", port.value.port)
      }
    }
    selector = {
      "app.kubernetes.io/name" = var.app_name
    }
    cluster_ip = "None"
    type = lookup(var.set_k8s_service, "type", "clusterIP")
  }
}
