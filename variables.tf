variable "environment" {
  description = "Environment name"
  type        = string
}

variable "resource_groups" {
  description = "Map of Resource Groups to create"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
}

variable "vnets" {
  description = "Map of VNets to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    dns_servers         = optional(list(string), [])
    tags                = optional(map(string), {})
  }))
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    name                                          = string
    resource_group_name                           = string
    virtual_network_name                          = string
    address_prefixes                              = list(string)
    service_endpoints                             = optional(list(string), [])
    private_endpoint_network_policies             = optional(string, "Enabled")
    private_link_service_network_policies_enabled = optional(bool, true)
  }))
}

variable "nsgs" {
  description = "Map of Network Security Groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string), {})
  }))
}

variable "nsg_associations" {
  description = "Map of subnet to NSG associations"
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}

variable "nsg_rules" {
  description = "Map of NSG rules"
  type = map(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
    resource_group_name         = string
    network_security_group_name = string
  }))
}

variable "firewalls" {
  description = "Map of Azure Firewalls"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku_name            = string
    sku_tier            = string
    subnet_key          = string
    public_ip_name      = string
    tags                = optional(map(string), {})
  }))
}

variable "route_tables" {
  description = "Map of Route Tables"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string), {})
  }))
}

variable "routes" {
  description = "Map of routes"
  type = map(object({
    name                = string
    resource_group_name = string
    route_table_key     = string
    address_prefix      = string
    next_hop_type       = string
    firewall_key        = optional(string)
  }))
}

variable "route_table_associations" {
  description = "Map of route table associations"
  type = map(object({
    subnet_key      = string
    route_table_key = string
  }))
}

variable "peerings" {
  description = "Map of VNet peerings"
  type = map(object({
    name                         = string
    resource_group_name          = string
    vnet_key                     = string
    remote_vnet_key              = string
    allow_virtual_network_access = optional(bool, true)
    allow_forwarded_traffic      = optional(bool, true)
    allow_gateway_transit        = optional(bool, false)
    use_remote_gateways          = optional(bool, false)
  }))
}

variable "firewall_policies" {
  description = "Map of Firewall Policies"
  type = map(object({
    name                     = string
    location                 = string
    resource_group_name      = string
    sku                      = string
    threat_intelligence_mode = optional(string, "Alert")
    tags                     = optional(map(string), {})
  }))
}
variable "firewall_rule_collection_groups" {
  description = "Map of Firewall Rule Collection Groups"
  type        = any
}

variable "nics" {
  description = "Map of Network Interfaces"
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    subnet_key                    = string
    private_ip_address_allocation = string
    private_ip_address            = optional(string)
    tags                          = optional(map(string), {})
  }))
}

variable "windows_vms" {
  type = any
}