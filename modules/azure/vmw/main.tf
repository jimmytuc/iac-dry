resource "azurerm_windows_virtual_machine" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size
  admin_username      = var.credentials.user
  admin_password      = var.credentials.passwd
  network_interface_ids = var.int_ids

  os_disk {
    caching              = var.os_disk.caching_type
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.size_in_gb
  }

  source_image_reference {
    publisher = var.vm_image.publisher
    offer     = var.vm_image.offer
    sku       = var.vm_image.sku
    version   = var.vm_image.version
  }

  tags                   = var.tags
}
