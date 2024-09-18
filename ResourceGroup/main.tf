# Create a resource group
resource "azurerm_resource_group" "oblig1" {
  name     = "rg-${var.project_name}-${var.location}-${var.environment}"
  location = var.location

  tags = var.common_tags
}

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