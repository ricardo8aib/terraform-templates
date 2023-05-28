# RDS Proxy

## General description

This template generates an RDS Proxy for an existing RDS instance. It also provides options to create the necessary VPCs, subnets, RDS instance, security groups, and database credentials with Secrets Manager. However, if you already have these resources, you can skip their creation.

## Set up

The `terraform.tfvars` contains basic configurations for the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the RDS Proxy

To create the RDS Proxy along with the required resources, run the make command `make create-rds-proxy` from the root directory of this repo or run the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the RDS Proxy

To delete the RDS Proxy along with the required resources, run the make command `make destroy-rds-proxy` from the root directory of this repo or run the following command within this directory:

``` bash
terraform destroy -auto-approve
```
