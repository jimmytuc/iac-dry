IAC tool: **terraform**

# Configure

1. Clone or copy the files in this path to a local directory and open a command prompt.
2. Amend `variables.tf` and `.auto.tfvars` with desired variables.
3. Log into azure using CLI: `az login` to obtain `env:ARM_CLIENT_ID` and `env:ARM_CLIENT_SECRET`

# Start provisioning

```terraform
terraform init
terraform validate
terraform plan -out deploy.tfplan
terraform apply deploy.tfplan
```
# Tear down

```terraform
terraform plan -destroy -out destroy.tfplan
terraform apply destroy.tfplan
```

# Migrating the backend state file (For remote storing state file)

Set up the backend infrastructure from the module `modules/azure/st` to obtain the storage account id and name.

In the file `provider.tf`, under section backend `azurerm`, uncomment relevant lines and provide values for

```terraform
terraform {
  required_version = ">= 1.2.4"
  backend "azurerm" {
    resource_group_name  = "rg-name" # (backend resource group name)
    storage_account_name = "st-name" # (backend storage account name)
    container_name       = "backend-remote-state"
    key                  = "environment.tfstate"
  }
  ...
}
```

Then, run `terraform init`

Note: please delete any local `.tfstate` or `.tfstate.backup` files as these may contain sensitive information if we did provision from local before

The backend state is now migrated to the backend storage account and container for the backend.
