################
##### KEY VAULT ################################
################
# Create a Client config for use with Key Vault
data "azurerm_client_config" "current" {}

# Create random id
resource "random_id" "random-id" {
  byte_length = 4
}

# Create a Key Vault
resource "azurerm_key_vault" "key-vault" {
  name                        = "kv-${var.project_name}-${random_id.random-id.hex}"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard" # Todo: Use a better name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List",
    ]

    storage_permissions = [
      "Get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"

    # virtual_network_subnet_ids = [  # TODO: Associate to subnets
    #   for subnet_id in var.subnet_ids : subnet_id
    # ]
  }

  tags = var.common_tags
}

# Create a Key Vault Secret Resource for Storage Account Access Key
resource "azurerm_key_vault_secret" "kv-sa-accesskey" {
  name         = var.sa_accesskey_name
  value        = var.sa_accesskey_value
  key_vault_id = azurerm_key_vault.key-vault.id
}

# Create a random Key Vault VM Secret Name
resource "random_string" "kv-vm-username" {
  length  = 13
  special = false
  lower   = true
  numeric = false
  upper   = false
}

# Create rendom password
resource "random_password" "kv-vm-password" {
  length           = 24
  special          = true
  override_special = "!#$%&,."
}

resource "azurerm_key_vault_secret" "kv-vm-username" {
  name         = "vm-username"
  value        = random_string.kv-vm-username.result
  key_vault_id = azurerm_key_vault.key-vault.id
}

resource "azurerm_key_vault_secret" "kv-vm-password" {
  name         = "vm-password"
  value        = random_password.kv-vm-password.result
  key_vault_id = azurerm_key_vault.key-vault.id
}