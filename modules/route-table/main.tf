resource "azurerm_route_table" "rt" {
  for_each            = var.route_tables
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags = merge(
    var.common_tags,
    each.value.tags
  )
}