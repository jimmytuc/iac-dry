dependencies {
  paths = ["../eks-cluster"]
}

include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  name = "external-dns"

  external_dns_chart_name    = "external-dns"
  external_dns_chart_repo    = "https://charts.bitnami.com/bitnami"
  external_dns_chart_version = "6.2.4"

  extra_values = yamlencode({
    "provider" : "cloudflare",
    "cloudflare" : {
      "email" : get_env("TF_VAR_cloudflare_email")
      "apiKey" : get_env("TF_VAR_cloudflare_api_key")
    }
  })
  domains = "domain.io"
  owner_id = "dev"
}

generate "provider-local" {
  path      = "provider-local.tf"
  if_exists = "overwrite"
  contents  = file("../providers/k8s.tf")
}

terraform {
  source = "../../..//modules/dns"
}
