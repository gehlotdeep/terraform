terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.32.1"
    }
  }
  backend "s3" {
    bucket       = "sdeep21june"
    key          = "env/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}
