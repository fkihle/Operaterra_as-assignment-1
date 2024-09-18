# Create a resource group
resource "azurerm_resource_group" "oblig1" {
  name     = "rg-${var.project_name}-${var.location}-${var.environment}"
  location = var.location

  tags = var.common_tags
}