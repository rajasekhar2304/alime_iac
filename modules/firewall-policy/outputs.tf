output "firewall_policy_ids" {
  description = "Map of Firewall Policy IDs"
  value = {
    for k, policy in azurerm_firewall_policy.policy :
    k => policy.id
  }
}

output "firewall_policy_names" {
  description = "Map of Firewall Policy names"
  value = {
    for k, policy in azurerm_firewall_policy.policy :
    k => policy.name
  }
}