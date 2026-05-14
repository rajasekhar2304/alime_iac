output "vm_extension_ids" {
  value = {
    for k, ext in azurerm_virtual_machine_extension.extension :
    k => ext.id
  }
}