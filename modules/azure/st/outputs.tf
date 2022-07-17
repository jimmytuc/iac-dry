output "storage_account_id" {
  value       = azurerm_storage_account.this.id
  description = "The resource ID for the storage account."
}

output "storage_account_name" {
  value       = azurerm_storage_account.this.name
  description = "The resource Name for the storage account."
}
