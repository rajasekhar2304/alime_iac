output "association_ids" {
  description = "Map of association IDs"
  value = {
    for k, association in azurerm_subnet_route_table_association.association :
    k => association.id
  }
}