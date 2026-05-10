output "vnet_names" {
  description = "Map of VNet names"
  value = {
    for k, vnet in azurerm_virtual_network.vnet :
    k => vnet.name
  }
}

output "vnet_ids" {
  description = "Map of VNet IDs"
  value = {
    for k, vnet in azurerm_virtual_network.vnet :
    k => vnet.id
  }
}

output "vnet_address_spaces" {
  description = "Map of VNet address spaces"
  value = {
    for k, vnet in azurerm_virtual_network.vnet :
    k => vnet.address_space
  }
}