output "peering_ids" {
  description = "Map of peering IDs"
  value = {
    for k, peering in azurerm_virtual_network_peering.peering :
    k => peering.id
  }
}