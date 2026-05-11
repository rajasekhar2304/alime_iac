output "nsg_rule_ids" {
  description = "Map of NSG Rule IDs"
  value = {
    for k, rule in azurerm_network_security_rule.rule :
    k => rule.id
  }
}