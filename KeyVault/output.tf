# # Handle output from KeyVault module
output "kv_vm_username" {
  value       = random_string.kv-vm-username.result
  description = "Username for the VM"
  sensitive   = false
}

output "kv_vm_pass" {
  value       = random_password.kv-vm-password.result
  description = "Password for the VM"
  sensitive   = true
}