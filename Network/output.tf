# Handle output from Network module
output "nic_ids" {
  value = azurerm_network_interface.nics[*].id
}

output "subnet_ranges" {
  value = var.subnet_ranges
}

output "subnet_ids" {
  value = azurerm_subnet.subnets[*].id
}