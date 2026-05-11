output "nsg_ids" {
  description = "Map of NSG IDs"
  value = {
    for k, nsg in azurerm_network_security_group.nsg :
    k => nsg.id
  }
}

output "nsg_names" {
  description = "Map of NSG names"
  value = {
    for k, nsg in azurerm_network_security_group.nsg :
    k => nsg.name
  }
}