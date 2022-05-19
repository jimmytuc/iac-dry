variable "name" {
  type        = string
  description = "Name of helm release"
}

variable "external_dns_chart_name" {
  type        = string
  description = "External DNS Helm chart name."
}

variable "external_dns_chart_repo" {
  type        = string
  description = "External DNS Helm repository name."
}

variable "external_dns_chart_version" {
  type        = string
  description = "External DNS Helm chart version."
}

variable "owner_id" {
  type        = string
  description = "Owner ID"
}

variable "domains" {
  type        = string
  description = "Domains list for External DNS to manage"
}

variable "extra_values" {
  type        = string
  default     = "please_ignore: me\n"
  description = "Extra (relative) path to helm value files. Default to null."
}
