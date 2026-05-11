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

# Subnet outputs #
output "subnet_ids" {
  value = module.subnets.subnet_ids
}

output "subnet_names" {
  value = module.subnets.subnet_names
}

output "subnet_address_prefixes" {
  value = module.subnets.subnet_address_prefixes
}

# NSG outputs #
output "nsg_ids" {
  value = module.nsgs.nsg_ids
}

output "nsg_names" {
  value = module.nsgs.nsg_names
}

# NSG association outputs #
output "nsg_association_ids" {
  value = module.nsg_associations.association_ids
}

# NSG rule outputs #
output "nsg_rule_ids" {
  value = module.nsg_rules.nsg_rule_ids
}

# Firewall outputs #
output "firewall_private_ips" {
  value = module.firewalls.firewall_private_ips
}

output "firewall_public_ips" {
  value = module.firewalls.firewall_public_ips
}