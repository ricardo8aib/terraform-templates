# Lambda Function with Pandas layer

## General description

This template generates a Lambda function that can use the Pandas library to work with data structures such as Series (1-dimensional) and DataFrame (2-dimensional).

## Set up

The `terraform.tfvars` contains basic configurations for the lambda and the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

### Important *

In order to use the Pandas library, these terraform scripts create a layer using the AWS provided layer for Pandas. To use a another version of pandas or any other library, refer the [Lambda Custom Layer](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/lambda-custom-layer) template.

## Creating the Lambda function

This function can be created using the make command `make create-lambda-pandas` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the Lambda function

This function can be deleted using the make command `make destroy-lambda-pandas` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```
