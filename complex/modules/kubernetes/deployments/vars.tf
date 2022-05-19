variable "app_namespace" {
  description = "Specify application/service namespace"
}
variable "app_name" {
  description = "Specify application name"
}
variable "app_version" {
  description = "Specify application/service version."
  default = "latest"
}
variable "expose_service" {
  description = "Whether enable the kubernetes service for exposing ports"
  default = false
}
variable "set_k8s_service" {
  description = "Specify the options of the kubernetes service for exposing the service to be served"
  type = object({
    name = string
    ports = list(object({
      #      name = string
      #      protocol = string
      port = number
      #      target = number
    }))
    type = string # ClusterIP, LoadBalancer and NodePort
  })
  default = null
}
variable "replicas" {
  type        = number
  description = "(Optional) Count of pods"
  default     = 1
}
variable "ecr_endpoint" {
  description = "Specify the ECR endpoint (URL)"
  default = "782606156876.dkr.ecr.us-east-2.amazonaws.com"
}
variable "app_containers" {
  description = "Specify the application/service containers list"
  type = list(object({
    name = string
    ecr_app_name = string
    ecr_app_version = string
    #env = list(object({ name = string, value = string })) # (Optional) Name and value pairs to set in the container's environment
    #env_from_secrets = set(string) # (Optional) Get secret keys from k8s and add as environment variables to pods
    #env_from_configmaps = set(string) # (Optional) Get configmap keys from k8s and add as environment variables to pods
    #internal_ports = list(map(any))
    #liveness_probe = list(map) # (Optional) Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated.
    #readiness_probe = list(map) #(Optional) Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated.
    #args = list(string)
    #    commands = list(string)
    #    volumes_mount = list(object({
    #      mount_path = string
    #      volume_name = string
    #      sub_path = string
    #      read_only = bool
    #    }))
    #    resources = map(any)
  }))
  default = []
}
variable "init_containers" {
  description = "Specify the init application/service containers list"
  type = list(object({
    name = string
    ecr_app_name = string
    ecr_app_version = string
    #env = list(object({ name = string, value = string })) # (Optional) Name and value pairs to set in the container's environment
    #env_from_secrets = set(string) # (Optional) Get secret keys from k8s and add as environment variables to pods
    #env_from_configmaps = set(string) # (Optional) Get configmap keys from k8s and add as environment variables to pods
    #internal_ports = list(map(any))
    #liveness_probe = list(map) # (Optional) Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated.
    #readiness_probe = list(map) #(Optional) Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated.
    #    args = list(string)
    #    commands = list(string)
    #    volumes_mount = list(object({
    #      mount_path = string
    #      volume_name = string
    #      sub_path = string
    #      read_only = bool
    #    }))
    #    resources = map(any)
  }))
  default = []
}
variable "restart_policy" {
  description = "Specify the restart policy for the job"
  default = "OnFailure"
}
variable "tolerations" {
  type = list(object({ key = string, value = string }))
  default = []
}
variable "volume_empty_dir" {
  type    = list(object({ volume_name = string }))
  default = []
}
variable "volume_claim" {
  description = "(Optional) Represents an Persistent volume Claim resource that is attached to a kubelet's host machine and then exposed to the pod"
  default     = []
}
variable "volume_configmap" {
  type        = list(object({
    name = string,
    volume_name = string,
    items = set(string)
  }))
  description = "(Optional) The data stored in a ConfigMap object can be referenced in a volume of type configMap and then consumed by containerized applications running in a Pod"
  default     = []
}
variable "volume_configmap_items" {
  type        = list(object({
    name = string,
    volume_name = string,
    items = list(object({
      key = string
      path = string
    }))
  }))
  description = "(Optional) The data stored in a ConfigMap object can be referenced in a volume of type configMap and then consumed by containerized applications running in a Pod"
  default     = []
}
variable "volume_secret" {
  description = "(Optional) Create volume from secret"
  default     = []
}
variable "prevent_deploy_on_the_same_node" {
  description = "Pod pod_anti_affinity rule, which prevents deploy same pod on one node."
  type        = bool
  default     = false
}
locals {
  platform_app = "application-platform"
}
