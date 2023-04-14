# Lambda Function with datadiff

## General description

This template generates a lambda function from an ECR image that can use the `datadiff` library and connect to a Snowflake database.

## Set up

The `terraform.tfvars` contains basic configurations for the lambda and the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.
Also, to avoid issues, make sure that the profaile used by terraform is the same as the default profile in `~/.aws/credentials`.

Users can add more libraries and specify the versions by modifying the [requirements.txt](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/lambda-data-diff/lambda_function/requirements.txt) file. The [push_image.sh](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/lambda-data-diff/push_image.sh) script builds the image using the lambda function in [app.py](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/lambda-data-diff/lambda_function/app.py) and the [Dockerfile](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/lambda-data-diff/lambda_function/Dockerfile).

## Creating the Lambda function

This function can be created using the make command `make create-lambda-data-diff` from the root directory of this repo or by running the following command within this directory:

``` bash
(terraform init; terraform apply -target=aws_ecr_repository.repository -auto-approve)
(bash push_image.sh)
(terraform init; terraform apply -auto-approve)
```

## Deleting the Lambda function

This function can be deleted using the make command `make destroy-lambda-data-diff` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```
