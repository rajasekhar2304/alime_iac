environment = "uat"
resource_groups = {
  rg = {
    name     = "alime-uat-rg"
    location = "Central India"
    tags = {
      owner = "devops"
    }
  }
}
vnets = {
  hub = {
    name                = "vnet-uat-hub"
    location            = "Central India"
    resource_group_name = "alime-uat-rg"
    address_space = ["10.52.0.0/16"]
    tags = {
      purpose = "hub"
    }
  }
  spoke = {

    name                = "vnet-uat-spoke"
    location            = "Central India"
    resource_group_name = "alime-uat-rg"
    address_space = ["10.53.0.0/16"]
    tags = {
      purpose = "spoke"
    }
  }
}