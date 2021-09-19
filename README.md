# Example deploying multiple environments for Terragrunt

This repo shows an example of how to use the modules from the `modules` repo to
deploy an Auto Scaling Group (ASG) and a Postgres DB across three environments (dev, uat, production) and two AWS accounts
(non-prod, production), all without duplicating any of the Terraform code. That's because there is just a single copy of
the Terraform code, defined in the `modules` repo, and in this repo, we solely define
`terragrunt.hcl` files that reference that code (at a specific version, too!) and fill in variables specific to each
environment.
