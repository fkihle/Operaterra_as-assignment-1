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

# Create public iPs
resource "azurerm_public_ip" "public_ips" {
  count = length(var.vm_names)

  name                = "public-ip-${var.project_name}-${count.index}"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"

  sku = "Standard"

  tags = var.common_tags
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
    public_ip_address_id          = azurerm_public_ip.public_ips[count.index].id
  }

  tags = var.common_tags
}

# Create a Network Security Group for all subnets
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

  tags = var.common_tags
}

# Create a dynamic rule for each public IP
resource "azurerm_network_security_rule" "ssh_rules" {
  count = length(azurerm_public_ip.public_ips)

  name                   = "sec-rule-SSH-${var.project_name}-${count.index}"
  priority               = 200 + count.index
  direction              = "Inbound"
  access                 = "Allow"
  protocol               = "Tcp"
  source_port_range      = "*"
  destination_port_range = "22"

  source_address_prefix      = azurerm_public_ip.public_ips[count.index].ip_address
  destination_address_prefix = "*"

  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = var.rg_name
}

# Associate NSG with each subnet
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count = length(azurerm_subnet.subnets)

  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}