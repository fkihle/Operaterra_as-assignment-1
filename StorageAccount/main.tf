################
##### STORAGE ACCOUNT ################################
################

# TODO: create random string to append to sa name

# Create Storage Account

resource "azurerm_storage_account" "storage-accounts" {
  # count = length(var.vm_names)

  # name                     = "sa${var.project_name}${count.index}"
  name                     = "sa${var.project_name}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard" # Todo: Make this dynamic / user friendly
  account_replication_type = "LRS"      # Todo: Make this dynamic / user friendly

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = var.subnet_ids
  }

  tags = var.common_tags
}