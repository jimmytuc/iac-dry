######
# Key Vault creating
######
module "kv" {
  source = "../../modules/azure/kv"

  name                    = replace(local.pattern, "_RST_", "kv")
  resource_group_location = module.rg.location
  resource_group_name     = module.rg.name
}

# generate password for the window virtual machine
resource "random_password" "vmw_credentials_passwd" {
  length  = 24
  special = false
}

resource "azurerm_key_vault_secret" "kv_secret_passwd" {
  depends_on   = [module.kv]

  name         = "${var.location_short}-kv-${var.environment}-secretpasswd"
  value        = random_password.vmw_credentials_passwd.result
  key_vault_id = module.kv.id
}
