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

## Spoke Ranges

* 10.200.0.0/21	- az-functions-secure-config
* 10.200.8.0/21	- az-sql-multi-region-cmk
* 10.200.16.0/21	
* 10.200.24.0/21	
* 10.200.32.0/21		
* 10.200.40.0/21	
* 10.200.48.0/21	
* 10.200.56.0/21	
* 10.200.64.0/21			
* 10.200.72.0/21	
* 10.200.80.0/21	
* 10.200.88.0/21	
* 10.200.96.0/21				
* 10.200.104.0/21		
* 10.200.112.0/21			
* 10.200.120.0/21		
* 10.200.128.0/21						
* 10.200.136.0/21		
* 10.200.144.0/21			
* 10.200.152.0/21		
* 10.200.160.0/21				
* 10.200.168.0/21		
* 10.200.176.0/21			
* 10.200.184.0/21		
* 10.200.192.0/21					
* 10.200.200.0/21		
* 10.200.208.0/21			
* 10.200.216.0/21		
* 10.200.224.0/21				
* 10.200.232.0/21		
* 10.200.240.0/21			
* 10.200.248.0/21		