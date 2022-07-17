locals {
  # [rs-location]-[rs-type]-[env]-{service}
  pattern = "${var.location_short}-_RST_-${var.environment}-${var.service_name}"
  default_tags = {
    Environment = var.environment
    CreatedBy = "terraform"
  }
}

######
# Resource group
######
module "rg" {
  source = "../../modules/azure/rg"

  name                = replace(local.pattern, "_RST_", "rg")
  location            = var.location
  tags                = merge({
    Location = var.location
    Resource = "rg"
    Project = var.service_name
  }, local.default_tags)
}

######
# Virtual network - Subnet
######
module "vnet_snet" {
  source = "../../modules/azure/vnet-snet"
  depends_on = [module.rg]

  resource_group_name     = module.rg.name
  resource_group_location = module.rg.location
  vnet_name               = replace(local.pattern, "_RST_", "vnet")
  subnet_name             = replace(local.pattern, "_RST_", "snet")
  cidr                    = ["192.168.0.0/23"]
  subnet_cidr             = ["192.168.0.0/26"]
  tags                    = merge({
    Location = var.location
    Resource = "vnet"
    Project = var.service_name
  }, local.default_tags)
}

######
# Network Security Group - Rules
######
module "nsg" {
  source = "../../modules/azure/nsg"
  depends_on = [module.rg]

  name                    = replace(local.pattern, "_RST_", "nsg")
  resource_group_location = module.rg.location
  resource_group_name     = module.rg.name

  rules                   = {
    rdp_inbound = {
      name                       = "RDP_IN"
      priority                   = 1000
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389" # 3389 is RDP default port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    rdp_outbound = {
      name                       = "RDP_OUT"
      priority                   = 1000
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags                    = merge({
    Location = var.location
    Resource = "nsg"
    Project = var.service_name
  }, local.default_tags)
}

######
# Network Interface Card
######
module "int" {
  source = "../../modules/azure/int"
  depends_on = [module.vnet_snet]

  name                    = replace(local.pattern, "_RST_", "int")
  resource_group_location = module.rg.location
  resource_group_name     = module.rg.name
  subnet_id               = module.vnet_snet.subnet_id
}

######
# Window Virtual Machine
######
module "vmw" {
  source = "../../modules/azure/vmw"
  depends_on = [module.rg, module.int, azurerm_key_vault_secret.kv_secret_passwd]

  vm_size                 = "Standard_B2s"
  os_disk                 = {
    size_in_gb           = "150"
    storage_account_type = "Premium_LRS"
    caching_type         = "ReadWrite"
  }
  vm_image                = {
    publisher            = "MicrosoftWindowsServer"
    offer                = "WindowsServer"
    sku                  = "2019-Datacenter-with-Containers"
    version              = "latest"
  }
  credentials             = {
    user                 = "admin"
    passwd               = azurerm_key_vault_secret.kv_secret_passwd.value
  }
  int_ids                 = module.int.inet_id
  resource_group_location = module.rg.location
  resource_group_name     = module.rg.name
  name                    = replace(local.pattern, "_RST_", "vmw")
}
