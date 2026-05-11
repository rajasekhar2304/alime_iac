variable "nsgs" {
  description = "Map of Network Security Groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags = optional(map(string), {})
  }))
}

variable "common_tags" {
  description = "Common tags"
  type = map(string)
}