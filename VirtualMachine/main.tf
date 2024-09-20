################
##### VIRTUAL MACHINE ################################
################

# Create VMs
resource "azurerm_linux_virtual_machine" "vms" {
  count = length(var.vm_names)

  name                = "vm-${var.project_name}-${count.index}"
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_F2"  # Todo: Make this dynamic / user friendly
  admin_username      = var.admin_user # Get username from secrets
  admin_password      = var.admin_pass # Get password from secrets
  network_interface_ids = [
    var.nic_ids[count.index],
  ]

  os_disk {
    caching              = "ReadWrite"    # Todo: Make this dynamic / user friendly
    storage_account_type = "Standard_LRS" # Todo: Make this dynamic / user friendly
  }

  source_image_reference { # Todo: Make this dynamic / user friendly
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04_lts"
    version   = "latest"
  }

  tags = var.common_tags
}


# Create Network Security Groups
module "network-security-group" {
  source                = "Azure/network-security-group/azurerm"
  resource_group_name   = var.rg_name
  location              = var.location
  security_group_name   = "nsg-${var.project_name}"
  source_address_prefix = var.subnet_ranges
  use_for_each          = true

  custom_rules = [
    {
      name                       = "sec-rule-HTTP-${var.project_name}"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = var.subnet_ranges
      description                = "network-security-rule-http"
    },
    {
      name                       = "sec-rule-http-mapping-${var.project_name}"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "tcp"
      source_port_range          = "80" # only allow access through port 80 (will this work??)
      destination_port_range     = "8080"
      source_address_prefixes    = var.subnet_ranges # only allow access from internal traffic (will this work??)
      destination_address_prefix = var.subnet_ranges
      description                = "network-security-rule-http-mapping"
    },
    {
      name                       = "sec-rule-SSH-${var.project_name}"
      priority                   = 102
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefixes    = "*" # Create a list of allowed IP ranges for future hardening
      destination_address_prefix = var.subnet_ranges
      description                = "network-security-rule-ssh"
    },
  ]

  tags = var.common_tags
}