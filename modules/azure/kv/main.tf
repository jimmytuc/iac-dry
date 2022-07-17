# get current account configuration
data "azurerm_client_config" "current" {}

locals {
  account_tenant_id = data.azurerm_client_config.current.tenant_id
  account_object_id = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault" "this" {
  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.resource_group_location

  tenant_id                   = local.account_tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  purge_protection_enabled    = var.purge_protection_enabled

  sku_name = "standard"

  access_policy {
    tenant_id = local.account_tenant_id
    object_id = local.account_object_id

    key_permissions     = var.key_permissions
    secret_permissions  = var.secret_permissions
    storage_permissions = var.storage_permissions
  }

  tags = var.tags
}
