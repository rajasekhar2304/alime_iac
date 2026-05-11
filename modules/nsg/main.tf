resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsgs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags = merge(
    var.common_tags,
    each.value.tags
  )
}