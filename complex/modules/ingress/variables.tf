variable "ingress_gateway_name" {
  type        = string
  description = "Ingress Gateway Helm chart name."
}

variable "ingress_gateway_chart_name" {
  type        = string
  description = "Ingress Gateway Helm chart name."
}

variable "ingress_gateway_chart_repo" {
  type        = string
  description = "Ingress Gateway Helm repository name."
}

variable "ingress_gateway_chart_version" {
  type        = string
  description = "Ingress Gateway Helm chart version."
}

variable "ingress_gateway_annotations" {
  type        = map(string)
  description = "Ingress Gateway Annotations required for EKS."
}
