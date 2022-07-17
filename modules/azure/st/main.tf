resource "azurerm_storage_account" "this" {
  name                      = var.storage_account_name
  resource_group_name       = var.resource_group_name
  location                  = var.resource_group_location
  access_tier               = var.sa_access_tier
  account_kind              = var.sa_account_kind
  account_tier              = var.sa_account_tier
  account_replication_type  = var.sa_account_repl
  enable_https_traffic_only = var.sa_account_https
  min_tls_version           = "TLS1_2"
  tags                      = var.tags
}

