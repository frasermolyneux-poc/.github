terraform {
  required_version = ">= 1.6.2"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.45.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "github" {
  owner = "frasermolyneux-poc"
}
