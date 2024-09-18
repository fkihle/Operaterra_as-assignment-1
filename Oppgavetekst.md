## Initialization & Basic Commands

Initialize a new Terraform configuration using terraform init.
Make sure to document how one can use terraform plan and terraform apply to create resources, and terraform destroy to remove them.

## Variables & Outputs

Use Input Variables to make the configuration flexible. Create variables for:  
- Resource group names
- Location
- Storage Account types
- SKU
- VM sizes
- etc.
- ..and where you see it most fit for flexability

If needed, use locals to set common attributes or compose new values from existing ones.  
Use Outputs to make sure you get the information needed from child modules and root module. This could be:  
- Public IP of the VM
- Subnet ID
- Key Vault Secret ID
- Storage Account connection string
- etc.

## Modules

Create the following child modules:  
- **Network Module**: To provision VNET, Subnet, and Network Security Group.
- **Storage Account Module**: To create an Azure Storage Account and a storage container.
- **Virtual Machine Module**: To provision an Azure Linux Virtual Machine.
- **Key Vault Module**: To provision Azure Key Vault and store secrets.
  
Use the root module to orchestrate these child modules.
Make sure to use output variables in child modules to pass information back to the root module or other child modules to make the configuration as flexible as posible.

## Azure Resources

NOTE! There are several new resources introduced in this assignment, but with your knowledge to use Terraform documentation for AzureRM, you should be able to figure out how to create the resources, and what attributes are mandatory and how to use them.

Resources to Create:
- VNET with at least one subnet
- At least one VM connected to the subnet
- At least one NSG that protects the VM from outside threats
- Azure Storage Account with at least one storage container
- Azure Key Vault with the following secrets:
- A secret holding the VM username and password
- A secret holding the Storrage Account Acces Key
- The VM should use the Key Vault VM secret with username and password 

## Deliverables

IMPORTANT!

A .zip-file with the following name, files and folders:
- Name the zip file with the ntnu username and oppg1, such as: melling-oppg1.zip 

- In the zip file there must be a folder with the same name as the zip file: ntnuusername-oppg1, such as: melling-oppg1. 

The folder naturally contains the terraform files and folders. The reason for the naming is to streamline censorship and display in VS Code.

Terraform configuration:  
- Terraform scripts for all modules and the root module.
- A README.md file explaining:
  - The purpose of each module
  - How to use the Terraform scripts
  - Any pre-requisites or dependencies
- A sample  .tfvars file containing sample values for all the input variables.
- Output screenshots showing the successful application deployed and destruction of resources.