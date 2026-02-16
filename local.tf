locals {
  ingress_rules = [
    {
      port        = 22
      description = "Open SSH"
    },
    {
      port        = 80
      description = "Apache Server"
    },
    {
      port        = 443
      description = "Nginx Server"
    }
  ]
}


