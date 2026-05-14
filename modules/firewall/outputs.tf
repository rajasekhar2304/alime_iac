output "firewall_ids" {
  value = {
    for k, fw in azurerm_firewall.firewall :
    k => fw.id
  }
}

output "firewall_private_ips" {
  value = {
    for k, fw in azurerm_firewall.firewall :
    k => fw.ip_configuration[0].private_ip_address
  }
}

output "firewall_public_ips" {
  value = {
    for k, pip in azurerm_public_ip.pip :
    k => pip.ip_address
  }
}

output "firewall_public_ip_ids" {
  value = {
    for k, pip in azurerm_public_ip.pip :
    k => pip.id
  }
}
