output "nic_ids" {
  description = "Map of NIC IDs"
  value = {
    for k, nic in azurerm_network_interface.nic :
    k => nic.id
  }
}

output "nic_private_ips" {
  description = "Map of NIC private IPs"
  value = {
    for k, nic in azurerm_network_interface.nic :
    k => nic.private_ip_address
  }
}

output "nic_names" {
  description = "Map of NIC names"
  value = {
    for k, nic in azurerm_network_interface.nic :
    k => nic.name
  }
}