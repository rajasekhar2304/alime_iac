resource "azurerm_firewall_policy" "policy" {
  for_each                 = var.firewall_policies
  name                     = each.value.name
  location                 = each.value.location
  resource_group_name      = each.value.resource_group_name
  sku                      = each.value.sku
  threat_intelligence_mode = each.value.threat_intelligence_mode
  tags = merge(
    var.common_tags,
    each.value.tags
  )
}