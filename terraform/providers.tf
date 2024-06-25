terraform {
  required_version = ">= 1.6.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.109.0"
    }
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

provider "azurerm" {
  alias = "molyneuxio"

  tenant_id       = "e56a6947-bb9a-4a6e-846a-1f118d1c3a14"
  subscription_id = "d68448b0-9947-46d7-8771-baa331a3063a"
  client_id       = var.running_locally == true ? null : "23224d07-5845-40d4-97c6-15a7eb1b16d9" //spn-frasermolyneux-poc-production

  use_oidc = var.running_locally == true ? false : true
  use_cli  = var.running_locally == true ? true : false

  features {}
}

provider "azurerm" {
  alias = "mngenv102652"

  tenant_id       = "76c09fbf-22c7-4ac4-9fdd-9f8f9c19e856"
  subscription_id = "ecc74148-1a84-4ec7-99bb-d26aba7f9c0d"
  client_id       = var.running_locally == true ? null : "2c43852a-179e-4e66-b363-a056f9a4e4f1" //spn-frasermolyneux-poc-production

  use_oidc = var.running_locally == true ? false : true
  use_cli  = var.running_locally == true ? true : false

  features {}
}

provider "github" {
  owner = "frasermolyneux-poc"
}
