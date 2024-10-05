terraform {
  required_version = ">= 1.6.2"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.3.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}

  storage_use_azuread = true
}

provider "github" {
  owner = var.github_org
}
