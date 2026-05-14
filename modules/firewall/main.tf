resource "azurerm_public_ip" "pip" {
  for_each            = var.firewalls
  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = merge(
    var.common_tags,
    each.value.tags
  )
}

resource "azurerm_firewall" "firewall" {
  for_each            = var.firewalls
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier
  firewall_policy_id  = each.value.firewall_policy_id
  ip_configuration {
    name                 = "firewall-ipconfig"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
  tags = merge(
    var.common_tags,
    each.value.tags
  )
}