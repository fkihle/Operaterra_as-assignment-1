################
##### KEY VAULT ################################
################
# Create a Client config for use with Key Vault
data "azurerm_client_config" "current" {}

# Create random id
resource "random_id" "oblig1-random-id" {
  byte_length = 4
}

# Create a Key Vault
resource "azurerm_key_vault" "oblig1-key-vault" {
  name                        = "kv-${var.project_name}-${var.location}-${var.environment}-${random_id.oblig1-random-id.hex}"
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

  tags = var.common_tags
}

# Create a random Key Vault VM Secret Name
resource "random_string" "oblig1-key-vault-vm-secret-name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Create rendom password
resource "random_password" "oblig1-key-vault-vm-password" {
  length           = 24
  special          = true
  override_special = "!#$%&,."
}

# Create a Key Vault Secret Resource
resource "azurerm_key_vault_secret" "oblig1-key-vault-vm-secret" {
  key_vault_id = azurerm_key_vault.oblig1-key-vault.id
  name         = random_string.oblig1-key-vault-vm-secret-name.result
  value        = random_password.oblig1-key-vault-vm-password.result
}