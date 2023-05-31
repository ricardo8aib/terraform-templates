# Lambda Function from ECR Image

## General description

This template generates a Lambda function using a Docker image stored in Amazon Elastic Container Registry (ECR). It also includes the creation of the ECR repository and pushing the Docker image to the repository.

## Set up

The `terraform.tfvars` contains basic configurations for the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. The bucket name can be also set there. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the Lambda function from ECR image

This function can be created using the make command `make create-lambda-ecr` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the Lambda function from ECR image

This function can be deleted using the make command `make destroy-lambda-scheduled` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```

Note: Deleting the resources will remove the Lambda function created from the ECR image, as well as the ECR repository and Docker image pushed to it.
