# Create a VNET
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project_name}"
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

  service_endpoints = ["Microsoft.Storage"]
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

# Create Network Security Groups
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.project_name}"
  resource_group_name = var.rg_name
  location            = var.location

  security_rule {
    name                       = "sec-rule-HTTP-${var.project_name}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "network-security-rule-http"
  }

  security_rule {
    name                       = "sec-rule-http-mapping-${var.project_name}"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "network-security-rule-http-mapping"
  }

  security_rule {
    name                       = "sec-rule-SSH-${var.project_name}"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "network-security-rule-ssh"
  }

  tags = var.common_tags
}