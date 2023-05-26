# Simple RDS instance

## General description

This template generates a RDS instance.

## Set up

The `terraform.tfvars` contains basic configurations for the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the RDS instance

This function can be created using the make command `make create-rds-simple` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the RDS instance

This function can be deleted using the make command `make destroy-rds-simple` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```
