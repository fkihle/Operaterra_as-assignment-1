output "sa_accesskey_name" {
  value       = azurerm_storage_account.oblig1-storage-accounts[*].name
  description = "Storage Account Access Key name"
  sensitive   = true
}

output "sa_accesskey_value" {
  value       = azurerm_storage_account.oblig1-storage-accounts[*].primary_access_key
  description = "Storage Account Access Key value"
  sensitive   = true
}