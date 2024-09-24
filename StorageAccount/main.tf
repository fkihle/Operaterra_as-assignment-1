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

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = var.subnet_ids
  }

  tags = var.common_tags
}

# Create Storage Container