resource "azurerm_virtual_machine_extension" "extension" {
  for_each                   = var.vm_extensions
  name                       = each.value.name
  virtual_machine_id         = each.value.virtual_machine_id
  publisher                  = each.value.publisher
  type                       = each.value.type
  type_handler_version       = each.value.type_handler_version
  auto_upgrade_minor_version = each.value.auto_upgrade_minor_version
  settings                   = each.value.settings
}