################
##### VIRTUAL MACHINE ################################
################

# Create VMs
resource "azurerm_linux_virtual_machine" "vms" {
  count = length(var.vm_names)

  name                            = "vm-${var.project_name}-${count.index}"
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = "Standard_F2"  # Todo: Make this dynamic
  admin_username                  = var.admin_user
  admin_password                  = var.admin_pass
  disable_password_authentication = false
  network_interface_ids = [
    var.nic_ids[count.index],
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.common_tags
}