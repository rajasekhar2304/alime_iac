variable "vnets" {
  description = "Map of VNets to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space = list(string)
    dns_servers = optional(list(string), [])
    tags = optional(map(string), {})
  }))
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type = map(string)
}