# Simple Lambda Function

## General description

This template generates a Lambda function.

## Set up

The `terraform.tfvars` contains basic configurations for the lambda and the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the Lambda function

This function can be created using the make command `make create-simple-lambda` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the Lambda function

This function can be deleted using the make command `make destroy-simple-lambda` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```
