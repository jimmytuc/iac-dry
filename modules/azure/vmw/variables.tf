variable "name" {
  type = string
  description = "Virtual Machine name."
}

variable "resource_group_name" {
  type = string
  description = "Resource group name."
}

variable "resource_group_location" {
  type = string
  description = "Resource group location."
}

variable "int_ids" {
  type = list(string)
  description = " A list of Network Interface IDs which should be attached to this Virtual Machine."
}

variable "vm_size" {
  type = string
  description = "Specify the Virtual Machine size."
  default = "Standard_F2" # DS1v2
}

variable "credentials" {
  type = object({
    user = string
    passwd = string
  })
  description = "Specify username and password to access to the Window Virtual Machine."
}

variable "os_disk" {
  type = object({
    size_in_gb = string
    storage_account_type = string
    caching_type = string
  })
  description = "Virtual Machine OS disk"
  default = {
    size_in_gb = "50"
    storage_account_type = "Standard_LRS"
    caching_type = "ReadWrite"
  }
}

variable "vm_image" {
  description = "Specify the Virtual Machine source image reference"
  type = object({
    publisher = string
    offer = string
    sku = string
    version = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    CreatedBy   = "terraform"
  }
}
