# Handle output from Network module
output "nic_ids" {
  value = azurerm_network_interface.nics[*].id
}