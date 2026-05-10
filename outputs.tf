# RG outputs #
output "resource_group_names" {
  value = module.resource_groups.resource_group_names
}

output "resource_group_ids" {
  value = module.resource_groups.resource_group_ids
}

# VNET outputs #
output "vnet_names" {
  value = module.vnets.vnet_names
}

output "vnet_ids" {
  value = module.vnets.vnet_ids
}

output "vnet_address_spaces" {
  value = module.vnets.vnet_address_spaces
}