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