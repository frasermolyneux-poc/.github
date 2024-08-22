# .github

This is the meta repository for the frasermolyneux-poc project and contains docs and terraform to manage PoC projects.

## Managed Resources

This repository contains configuration to manage: 

* Repositories that are contained within the [frasermolyneux-poc](https://github.com/frasermolyneux-poc) GitHub organisation.
* Deployment identities created in Microsoft Entra ID that are used by the PoC projects and their respective pipelines.

## Multi-Tenant Approach

One of the challenges that this approach intends to tackle is the need to use short-lived or multiple Azure tenants for developing and deploying PoC projects. e.g. the use of certain subscriptions that have a specified budget or tenants that have specific preview features enabled.

## Manual Configuration

To configure this project and relevant permissions the following manual steps have been created; the concept however is to automate everything (within reason!).

* This repository has been created manually.
* An environment has been created within the repository named `Production`
* The application configuration for a service principal has been created in [frasermolyneux/platform-workloads](https://github.com/frasermolyneux/platform-workloads/blob/main/terraform/poc_management.tf).
  * The following secrets have then been set in the `Production` environment:
    * `AZURE_TENANT_ID` - The MngEnv250956 tenant ID
    * `AZURE_CLIENT_ID` - The application (client) ID from the `spn-github-frasermolyneux-poc-production` application
    * `AZURE_SUBSCRIPTION_ID` - The subscription ID for the `ME-MngEnv250956-fmolyneux-1` subscription where the Terraform state file is stored.
    * `TERRAFORM_GITHUB_TOKEN` - A PAT for GitHub to allow management of the repositories
