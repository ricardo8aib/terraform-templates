# Lambda Function with EventBridge Scheduler

## General description

This template generates a Lambda function and configures an EventBridge scheduler to trigger the function at specified intervals.

## Set up

The `terraform.tfvars` contains basic configurations for the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. The bucket name can be also set there. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the Lambda function and EventBridge scheduler

This function can be created using the make command `make create-lambda-scheduled` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the Lambda function and EventBridge scheduler

This function can be deleted using the make command `make destroy-lambda-scheduled` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```
