

########################################################################

# TODO
# - Azure Key Vault with the following secrets:
# - A secret holding the VM username and password
# - A secret holding the Storage Account Access Key
# - The VM should use the Key Vault VM secret with username and password 

########################################################################



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
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

################
##### MAIN RESOURCE GROUP ################################
################

# Create a resource group from module
module "ResourceGroup" {
  source       = "./ResourceGroup"
  project_name = "opera-terra-oblig-1"
  location     = "westeurope"
  environment  = "test"
  costcenter   = "utvikling-001"

  # Tags
  common_tags = local.common_tags
}

################
##### NETWORK ################################
################

# Create network from module
module "Network" {
  source        = "./Network"
  vnet_range    = "10.13.37.0/24"
  subnet_ranges = ["10.13.37.0/26", "10.13.37.64/26", "10.13.37.128/26", "10.13.37.192/26"]

  vm_names     = module.VirtualMachine.vm_names
  location     = module.ResourceGroup.location
  project_name = module.ResourceGroup.project_name
  rg_name      = module.ResourceGroup.rg_name

  # Tags
  common_tags = local.common_tags
}


################
##### VIRTUAL MACHINE ################################
################

# Create VMs from module
module "VirtualMachine" {
  source   = "./VirtualMachine"
  vm_names = ["server-01", "server-02", "server-03"]

  location      = module.ResourceGroup.location
  project_name  = module.ResourceGroup.project_name
  rg_name       = module.ResourceGroup.rg_name
  subnet_ranges = module.Network.subnet_ranges
  nic_ids       = module.Network.nic_ids

  admin_user = module.KeyVault.kv_vm_username
  admin_pass = module.KeyVault.kv_vm_pass

  # Tags
  common_tags = local.common_tags
}


################
##### STORAGE ACCOUNT ################################
################

# Create Storage Account from module
module "StorageAccount" {
  source = "./StorageAccount"

  vm_names     = module.VirtualMachine.vm_names
  location     = module.ResourceGroup.location
  project_name = module.ResourceGroup.project_name
  rg_name      = module.ResourceGroup.rg_name
  subnet_ids   = module.Network.subnet_ids
  common_tags  = local.common_tags
}

################
##### KEY VAULT ################################
################

# Create Key Vault from module
module "KeyVault" {
  source = "./KeyVault"

  location     = module.ResourceGroup.location
  project_name = module.ResourceGroup.project_name
  environment  = module.ResourceGroup.environment
  rg_name      = module.ResourceGroup.rg_name
  common_tags  = local.common_tags

  sa_accesskey_name  = module.StorageAccount.sa_accesskey_name
  sa_accesskey_value = module.StorageAccount.sa_accesskey_value
}