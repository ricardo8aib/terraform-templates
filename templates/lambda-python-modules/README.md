# Lambda Function with Custom Python Modules

## General description

This template generates a Lambda function that utilizes custom Python modules.

## Set up

The `terraform.tfvars` contains basic configurations for the lambda and the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the Lambda function with custom Python modules

1. Place your custom Python modules in the src directory.
2. Update the app.py file with the necessary code that imports and utilizes your custom modules.
3. Run the the make command `create-lambda-python-modules` from the root directory of this repo or run the following commands within the infrastructure directory:

``` bash
terraform init
terraform apply -target=aws_ecr_repository.repository -auto-approve
bash push_image.sh
terraform init
terraform apply -auto-approve
```

## Deleting the Lambda function

This function can be deleted using the make command `destroy-lambda-python-modules` from the root directory of this repo or by running the following command within the infrastructure directory:

``` bash
terraform destroy -auto-approve
```
