output "association_ids" {
  description = "Map of NSG association IDs"
  value = {
    for k, association in azurerm_subnet_network_security_group_association.association :
    k => association.id
  }
}