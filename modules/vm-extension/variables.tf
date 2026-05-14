variable "vm_extensions" {
  description = "Map of VM Extensions"
  type = map(object({
    name                       = string
    virtual_machine_id         = string
    publisher                  = string
    type                       = string
    type_handler_version       = string
    auto_upgrade_minor_version = bool
    settings                   = string
    tags                       = optional(map(string), {})
  }))
}