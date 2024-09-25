################
##### STORAGE ACCOUNT ################################
################

# TODO: create random string to append to sa name

# Create Storage Account
resource "azurerm_storage_account" "storage-accounts" {
  name                     = "sa${var.project_name}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.common_tags
}

# Create Storage Container
resource "azurerm_storage_container" "storage-container" {
  name                  = "sc${var.project_name}"
  storage_account_name  = azurerm_storage_account.storage-accounts.name
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.storage-accounts
  ]
}