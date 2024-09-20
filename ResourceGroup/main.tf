# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}"
  location = var.location

  tags = var.common_tags
}