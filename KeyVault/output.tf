# Handle output from KeyVault module
output "kv_vm_username" {
  value       = azurerm_key_vault_secret.oblig1-key-vault-vm-secret.name
  description = "Username for the VM"
  sensitive   = true
}

output "kv_vm_pass" {
  value       = azurerm_key_vault_secret.oblig1-key-vault-vm-secret.value
  description = "Password for the VM"
  sensitive   = true
}