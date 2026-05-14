resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    private_ip_address = (
      each.value.private_ip_address_allocation == "Static"
      ? each.value.private_ip_address
      : null
    )
  }

  tags = merge(
    var.common_tags,
    each.value.tags
  )
}