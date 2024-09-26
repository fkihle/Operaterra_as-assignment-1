
################
##### PROVIDERS and DEPENDENCIES ################################
################

# Include resource dependencies
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

# Provide the relevant Subscription ID for connection to Azure tennant
provider "azurerm" {
  subscription_id = var.subscription_id

  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }
}

################
##### MAIN RESOURCE GROUP ################################
################

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}"
  location = var.location

  tags = local.common_tags
}

################
##### NETWORK ################################
################

# Create network from module
module "Network" {
  source = "./Network"

  vnet_range    = var.vnet_range
  subnet_ranges = var.subnet_ranges
  vm_names      = var.vm_names

  rg_name      = azurerm_resource_group.rg.name
  location     = azurerm_resource_group.rg.location
  project_name = var.project_name
  common_tags  = local.common_tags
}

################
##### VIRTUAL MACHINE ################################
################

# Create VMs from module
module "VirtualMachine" {
  source = "./VirtualMachine"

  vm_names = var.vm_names

  rg_name      = azurerm_resource_group.rg.name
  location     = azurerm_resource_group.rg.location
  project_name = var.project_name
  common_tags  = local.common_tags

  nic_ids = module.Network.nic_ids

  admin_user = module.KeyVault.kv_vm_username
  admin_pass = module.KeyVault.kv_vm_pass
  depends_on = [module.KeyVault]
}

################
##### STORAGE ACCOUNT ################################
################

# Create Storage Account from module
module "StorageAccount" {
  source = "./StorageAccount"

  rg_name      = azurerm_resource_group.rg.name
  location     = azurerm_resource_group.rg.location
  project_name = var.project_name
  common_tags  = local.common_tags
}

################
##### KEY VAULT ################################
################

# Create Key Vault from module
module "KeyVault" {
  source = "./KeyVault"

  rg_name      = azurerm_resource_group.rg.name
  location     = azurerm_resource_group.rg.location
  project_name = var.project_name
  common_tags  = local.common_tags

  # subnet_ids = module.Network.subnet_ids  # TODO: Associate Key Vault to subnets

  sa_accesskey_name  = module.StorageAccount.sa_accesskey_name
  sa_accesskey_value = module.StorageAccount.sa_accesskey_value
}