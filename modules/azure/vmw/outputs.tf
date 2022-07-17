output "vmw_admin_username" {
  description = "Windows Virtual Machine administrator account username"
  value       = var.credentials.user
  sensitive   = true
}

output "vmw_admin_password" {
  description = "Windows Virtual Machine administrator account password"
  value       = var.credentials.passwd
  sensitive   = true
}

output "vmw_id" {
  value = azurerm_windows_virtual_machine.main.id
}
