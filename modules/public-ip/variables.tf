variable "public_ips" {
  description = "Map of Public IPs"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method = string
    sku               = string
    domain_name_label = optional(string)
    tags = optional(map(string), {})
  }))
}

variable "common_tags" {
  type = map(string)
}