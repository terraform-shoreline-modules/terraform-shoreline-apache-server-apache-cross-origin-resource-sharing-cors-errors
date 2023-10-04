terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "apache_cross_origin_resource_sharing_cors_errors" {
  source    = "./modules/apache_cross_origin_resource_sharing_cors_errors"

  providers = {
    shoreline = shoreline
  }
}