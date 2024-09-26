# Handle output from Network module
output "nic_ids" {
  value = azurerm_network_interface.nics[*].id
}

# output "subnet_ids" {    # TODO: Associate to subnets
#   value = [for subnet in azurerm_subnet.subnets : subnet.id]
# }