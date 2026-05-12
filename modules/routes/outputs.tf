output "route_ids" {
  description = "Map of route IDs"
  value = {
    for k, route in azurerm_route.route :
    k => route.id
  }
}