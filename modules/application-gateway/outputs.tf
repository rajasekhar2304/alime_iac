output "application_gateway_ids" {
  value = {
    for k, agw in azurerm_application_gateway.agw :
    k => agw.id
  }
}

output "application_gateway_names" {
  value = {
    for k, agw in azurerm_application_gateway.agw :
    k => agw.name
  }
}