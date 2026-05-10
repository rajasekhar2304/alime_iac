environment = "dev"
resource_groups = {
  rg = {
    name     = "alime-dev-rg"
    location = "Central India"
    tags = {
      owner = "devops"
    }
  }
}
vnets = {
  hub = {
    name                = "vnet-dev-hub"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    address_space       = ["10.48.0.0/16"]
    tags = {
      purpose = "hub"
    }
  }
  spoke = {

    name                = "vnet-dev-spoke"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    address_space       = ["10.49.0.0/16"]
    tags = {
      purpose = "spoke"
    }
  }
}