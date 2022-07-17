terraform {
  required_version = ">= 1.2.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.14"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }

#  backend "azurerm" {
#    resource_group_name  = "rg-name"
#    storage_account_name = "st-name"
#    container_name       = "backend-remote-state"
#    key                  = "environment.tfstate"
#  }
}

provider "azurerm" {
  features {}
}
