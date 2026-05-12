output "firewall_rule_collection_group_ids" {
  value = {
    for k, rcg in azurerm_firewall_policy_rule_collection_group.rcg :
    k => rcg.id
  }
}