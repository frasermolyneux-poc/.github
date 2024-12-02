terraform {
  required_version = ">= 1.6.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.12"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.3.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  storage_use_azuread = true
}

provider "github" {
  owner = var.github_org
}
