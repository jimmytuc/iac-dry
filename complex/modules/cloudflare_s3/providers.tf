terraform {
  required_version = "~> 1.1.2"
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    aws = {
      source  = "hashicorp/aws"
    }
    random = {
      source  = "hashicorp/random"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}
