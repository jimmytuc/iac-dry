output "name" {
  value = kubernetes_deployment.main.metadata[0].name
}
output "id" {
  value = kubernetes_deployment.main.metadata[0].uid
}
