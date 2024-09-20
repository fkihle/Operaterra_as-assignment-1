# Create a VNET
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project_name}-${var.location}-${var.environment}"
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = [var.vnet_range]

  tags = var.common_tags
}

# Create subnets
resource "azurerm_subnet" "subnets" {
  count = length(var.subnet_ranges)

  name                 = "snet-${var.project_name}-${count.index}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.rg_name
  address_prefixes     = [var.subnet_ranges[count.index]]
}

# Create a network interface for use with VMs
resource "azurerm_network_interface" "nics" {
  count = length(var.vm_names)

  name                = "nic-${var.project_name}-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets[count.index % length(var.subnet_ranges)].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.common_tags
}