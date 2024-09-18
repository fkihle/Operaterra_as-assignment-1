# Handle output from ResourceGroup module
output "rg_name" {
  value = azurerm_resource_group.oblig1.name
}

output "project_name" {
  value = var.project_name
}

output "location" {
  value = var.location
}

output "environment" {
  value = var.environment
}

output "costcenter" {
  value = var.costcenter
}