output "subnet_ids" {
  description = "Map of subnet IDs"
  value = {
    for k, subnet in azurerm_subnet.subnet :
    k => subnet.id
  }
}

output "subnet_names" {
  description = "Map of subnet names"
  value = {
    for k, subnet in azurerm_subnet.subnet :
    k => subnet.name
  }
}

output "subnet_address_prefixes" {
  description = "Map of subnet address prefixes"
  value = {
    for k, subnet in azurerm_subnet.subnet :
    k => subnet.address_prefixes
  }
}