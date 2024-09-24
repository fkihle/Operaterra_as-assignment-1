# Handle output from StorageAccount module
output "sa_accesskey_name" {
  value       = azurerm_storage_account.storage-accounts.name
  description = "Storage Account Access Key name"
  sensitive   = true
}

output "sa_accesskey_value" {
  value       = azurerm_storage_account.storage-accounts.primary_access_key
  description = "Storage Account Access Key value"
  sensitive   = true
}