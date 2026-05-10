environment = "prod"
resource_groups = {
  rg = {
    name     = "alime-prod-rg"
    location = "Central India"
    tags = {
      owner = "devops"
    }
  }
}
vnets = {
  hub = {
    name                = "vnet-prod-hub"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    address_space       = ["10.50.0.0/16"]
    tags = {
      purpose = "hub"
    }
  }
  spoke = {

    name                = "vnet-prod-spoke"
    location            = "Central India"
    resource_group_name = "alime-prod-rg"
    address_space       = ["10.51.0.0/16"]
    tags = {
      purpose = "spoke"
    }
  }
}