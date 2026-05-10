environment = "dev"
resource_groups = {
  rg-1 = {
    name     = "alime-rg-dev-1"
    location = "Central India"
    tags = {
      environment = "dev"
      owner       = "devops"
    }
  }
}