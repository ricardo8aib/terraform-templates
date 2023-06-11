# ECR Repository and Docker Image Push

## General description

This template generates an Amazon Elastic Container Registry (ECR) repository and pushes a Docker image to the repository.

## Set up

The `terraform.tfvars` contains basic configurations for the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the ECR repository and pushing the Docker image

The make command `make create-ecr-and-image` from the root directory of this repo creates the ECR repository and pushes the Docker image. An alternative is to run the following commands within this directory:

``` bash
terraform init
terraform apply -auto-approve
bash push_image.sh
```

## Deleting the ECR repository

This ECR repo can be deleted using the make command `make destroy-ecr-and-image` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```
