variable "windows_vms" {
  description = "Map of Windows VMs"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    size = string
    network_interface_ids = list(string)
    admin_username = string
    admin_password = string
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    tags = optional(map(string), {})
  }))
}

variable "common_tags" {
  type = map(string)
}