output "public_ip_ids" {
  value = {
    for k, pip in azurerm_public_ip.pip :
    k => pip.id
  }
}

output "public_ip_addresses" {
  value = {
    for k, pip in azurerm_public_ip.pip :
    k => pip.ip_address
  }
}

output "public_ip_names" {
  value = {
    for k, pip in azurerm_public_ip.pip :
    k => pip.name
  }
}