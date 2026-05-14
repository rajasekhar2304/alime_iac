variable "nics" {
  description = "Map of Network Interfaces"
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    subnet_id                     = string
    private_ip_address_allocation = string
    private_ip_address            = optional(string)
    tags                          = optional(map(string), {})
  }))
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}