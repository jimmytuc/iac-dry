resource "kubernetes_deployment" "main" {
  metadata {
    name = var.app_name
    namespace = var.app_namespace
    labels = {
      "app.kubernetes.io/name" = var.app_name
      "app.kubernetes.io/version" = var.app_version
      "app.kubernetes.io/part-of" = local.platform_app
    }
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        "app.kubernetes.io/name" = var.app_name
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_unavailable = "0"
        max_surge = "1"
      }
    }
    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = var.app_name
          "app.kubernetes.io/version" = var.app_version
          "app.kubernetes.io/part-of" = local.platform_app
        }
      }
      spec {
        restart_policy = var.restart_policy
        dynamic "toleration" {
          for_each = var.tolerations
          content {
            key = toleration.value.key
            value = toleration.value.value
          }
        }
        dynamic "affinity" {
          for_each = var.prevent_deploy_on_the_same_node ? [{}] : []
          content {
            pod_anti_affinity {
              required_during_scheduling_ignored_during_execution {
                label_selector {
                  match_expressions {
                    key = "app.kubernetes.io/name"
                    operator = "In"
                    values = [var.app_name]
                  }
#                 match_labels = local.labels
                }
                topology_key = "kubernetes.io/hostname"
              }
            }
          }
        }
        dynamic "container" {
          for_each = var.app_containers
          content {
            name = container.value.name
            image = "${var.ecr_endpoint}/${container.value.ecr_app_name}:${container.value.ecr_app_version}"
            args = lookup(container.value, "args", [])
            command = lookup(container.value, "commands", [])
            image_pull_policy = "Always"
            dynamic "env" {
              for_each = lookup(container.value, "env", []) # var.env
              content {
                name  = env.value.name
                value = env.value.value
              }
            }
            dynamic "env_from" {
              for_each = lookup(container.value, "env_from_secrets", []) # var.env_from_secrets
              content {
                secret_ref {
                  name = env_from.value
                }
              }
            }
            dynamic "env_from" {
              for_each = lookup(container.value, "env_from_configmaps", []) # var.env_from_configmaps
              content {
                config_map_ref {
                  name = env_from.value
                }
              }
            }
            dynamic "volume_mount" {
              for_each = lookup(container.value, "volumes_mount", [])
              content {
                mount_path = volume_mount.value.mount_path
                name       = volume_mount.value.volume_name
                sub_path   = lookup(volume_mount.value, "sub_path", null)
                read_only  = lookup(volume_mount.value, "read_only", false)
              }
            }
            dynamic "resources" {
              for_each = length(lookup(container.value, "resources", [])) == 0 ? [] : [{}]
              content {
                requests = {
                  cpu    = lookup(container.value.resources, "request_cpu", null)
                  memory = lookup(container.value.resources, "request_memory", null)
                }
                limits = {
                  cpu    = lookup(container.value.resources, "limit_cpu", null)
                  memory = lookup(container.value.resources, "limit_memory", null)
                }
              }
            }
            dynamic "port" {
              for_each = lookup(container.value, "internal_ports", [])
              content {
                container_port = port.value.internal_port
                name           = substr(lookup(port.value, "name", "http-${port.value.internal_port}"), 0, 14)
                host_port      = lookup(port.value, "host_port", null)
              }
            }
            dynamic "liveness_probe" {
              for_each = flatten([
                lookup(container.value, "liveness_probe", [])
              ])
              content {
                initial_delay_seconds = lookup(liveness_probe.value, "initial_delay_seconds", null)
                period_seconds        = lookup(liveness_probe.value, "period_seconds", null)
                timeout_seconds       = lookup(liveness_probe.value, "timeout_seconds", null)
                success_threshold     = lookup(liveness_probe.value, "success_threshold", null)
                failure_threshold     = lookup(liveness_probe.value, "failure_threshold", null)

                dynamic "http_get" {
                  for_each = contains(keys(liveness_probe.value), "http_get") ? [liveness_probe.value.http_get] : []

                  content {
                    path   = lookup(http_get.value, "path", null)
                    port   = lookup(http_get.value, "port", null)
                    scheme = lookup(http_get.value, "scheme", null)
                    host   = lookup(http_get.value, "host", null)

                    dynamic "http_header" {
                      for_each = contains(keys(http_get.value), "http_header") ? http_get.value.http_header : []
                      content {
                        name  = http_header.value.name
                        value = http_header.value.value
                      }
                    }
                  }
                }
                dynamic "exec" {
                  for_each = contains(keys(liveness_probe.value), "exec") ? [liveness_probe.value.exec] : []
                  content {
                    command = exec.value.command
                  }
                }
                dynamic "tcp_socket" {
                  for_each = contains(keys(liveness_probe.value), "tcp_socket") ? [liveness_probe.value.tcp_socket] : []
                  content {
                    port = tcp_socket.value.port
                  }
                }
              }
            }

            dynamic "readiness_probe" {
              for_each = flatten([
                lookup(container.value, "readiness_probe", [])
              ])
              content {
                initial_delay_seconds = lookup(readiness_probe.value, "initial_delay_seconds", null)
                period_seconds        = lookup(readiness_probe.value, "period_seconds", null)
                timeout_seconds       = lookup(readiness_probe.value, "timeout_seconds", null)
                success_threshold     = lookup(readiness_probe.value, "success_threshold", null)
                failure_threshold     = lookup(readiness_probe.value, "failure_threshold", null)

                dynamic "http_get" {
                  for_each = contains(keys(readiness_probe.value), "http_get") ? [readiness_probe.value.http_get] : []

                  content {
                    path   = lookup(http_get.value, "path", null)
                    port   = lookup(http_get.value, "port", null)
                    scheme = lookup(http_get.value, "scheme", null)
                    host   = lookup(http_get.value, "host", null)

                    dynamic "http_header" {
                      for_each = contains(keys(http_get.value), "http_header") ? http_get.value.http_header : []
                      content {
                        name  = http_header.value.name
                        value = http_header.value.value
                      }
                    }

                  }
                }
                dynamic "exec" {
                  for_each = contains(keys(readiness_probe.value), "exec") ? [readiness_probe.value.exec] : []
                  content {
                    command = exec.value.command
                  }
                }
                dynamic "tcp_socket" {
                  for_each = contains(keys(readiness_probe.value), "tcp_socket") ? [readiness_probe.value.tcp_socket] : []
                  content {
                    port = tcp_socket.value.port
                  }
                }
              }
            }

          }
        }
        dynamic "init_container" {
          for_each = var.init_containers
          content {
            name = init_container.value.name
            image = "${var.ecr_endpoint}/${init_container.value.ecr_app_name}:${init_container.value.ecr_app_version}"
            args = lookup(init_container.value, "args", [])
            command = lookup(init_container.value, "commands", [])
            dynamic "volume_mount" {
              for_each = lookup(init_container.value, "volumes_mount", [])
              content {
                mount_path = volume_mount.value.mount_path
                name       = volume_mount.value.volume_name
                sub_path   = lookup(volume_mount.value, "sub_path", null)
                read_only  = lookup(volume_mount.value, "read_only", false)
              }
            }
          }
        }
        dynamic "volume" {
          for_each = var.volume_empty_dir
          content {
            empty_dir {}
            name = volume.value.volume_name
          }
        }
        dynamic "volume" {
          for_each = var.volume_configmap
          content {
            name = volume.value.volume_name
            config_map {
              name = volume.value.name
              dynamic "items" {
                for_each = volume.value.items
                content {
                  key  = items.value
                  path = items.value
                }
              }
            }
          }
        }
        dynamic "volume" {
          for_each = var.volume_configmap_items
          content {
            name = volume.value.volume_name
            config_map {
              name = volume.value.name
              dynamic "items" {
                for_each = lookup(volume.value, "items", [])
                content {
                  key  = items.value.key
                  path = items.value.path
                }
              }
            }
          }
        }
        dynamic "volume" {
          for_each = var.volume_secret
          content {
            name = volume.value.volume_name
            secret {
              secret_name  = volume.value.secret_name
              default_mode = lookup(volume.value, "default_mode", null)
              optional     = lookup(volume.value, "optional", null)
              dynamic "items" {
                for_each = lookup(volume.value, "items", [])
                content {
                  key  = items.value.key
                  path = items.value.path
                  mode = lookup(items.value, "mode", null)
                }
              }
            }
          }
        }
        dynamic "volume" {
          for_each = var.volume_claim
          content {
            name = volume.value.volume_name
            persistent_volume_claim {
              claim_name = lookup(volume.value, "claim_name", null)
              read_only  = lookup(volume.value, "read_only", null)
            }
          }
        }
      }
    }
  }
}
