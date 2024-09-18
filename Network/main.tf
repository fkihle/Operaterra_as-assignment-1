# Create a VNET
resource "azurerm_virtual_network" "oblig1-vnet" {
  name                = "vnet-${var.project_name}-${var.location}-${var.environment}"
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = [var.vnet_range]

  tags = var.common_tags
}

# Create subnets
resource "azurerm_subnet" "oblig1-subnets" {
  count = length(var.subnet_ranges)

  name                 = "snet-${var.project_name}-${var.location}-${var.environment}-${count.index}"
  virtual_network_name = azurerm_virtual_network.oblig1-vnet.name
  resource_group_name  = var.rg_name
  address_prefixes     = [var.subnet_ranges[count.index]]
}

# Create a network interface for use with VMs
resource "azurerm_network_interface" "oblig1-network-interface" {
  count = length(var.vm_names)

  name                = "nic-${var.project_name}-${var.location}-${var.environment}-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.oblig1-subnets[count.index % length(var.subnet_ranges)].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.common_tags
}

output "nic_ids" {
  value = azurerm_network_interface.oblig1-network-interface[*].id
}

output "subnet_ranges" {
  value = var.subnet_ranges
}

output "subnet_ids" {
  value = azurerm_subnet.oblig1-subnets[*].id
}