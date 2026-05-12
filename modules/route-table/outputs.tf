output "route_table_ids" {
  description = "Map of Route Table IDs"
  value = {
    for k, rt in azurerm_route_table.rt :
    k => rt.id
  }
}

output "route_table_names" {
  description = "Map of Route Table names"
  value = {
    for k, rt in azurerm_route_table.rt :
    k => rt.name
  }
}