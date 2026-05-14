output "vm_ids" {
  value = {
    for k, vm in azurerm_windows_virtual_machine.vm :
    k => vm.id
  }
}

output "vm_names" {
  value = {
    for k, vm in azurerm_windows_virtual_machine.vm :
    k => vm.name
  }
}