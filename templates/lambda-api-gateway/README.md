# Lambda Function with API Gateway

## General description

This template generates a Lambda function and configures an API Gateway as a trigger for the function.

## Set up

The `terraform.tfvars` contains basic configurations for the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the ECR repository and pushing the Docker image

The make command `make create-lambda-api-gateway` from the root directory of this repo creates Lambda function with API Gateway. An alternative is to run the following commands within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the ECR repository

To delete the Lambda function and API Gateway, run the following command `make destroy-lambda-api-gateway` from the root directory of this repo or run the following command within this directory:

``` bash
terraform destroy -auto-approve
```

Note: Deleting the resources will remove the Lambda function and the associated API Gateway.

## Additional References

Here are some additional references that you may find helpful:

- [AWS API Gateway with Terraform](https://medium.com/onfido-tech/aws-api-gateway-with-terraform-7a2bebe8b68f)
- [Terraform AWS Provider - Serverless with AWS Lambda and API Gateway](https://registry.terraform.io/providers/hashicorp/aws/2.34.0/docs/guides/serverless-with-aws-lambda-and-api-gateway)
- [YouTube Video: AWS API Gateway with Lambda Function](https://www.youtube.com/watch?v=rdyMHi0WqpI)

These resources provide valuable information and tutorials on working with AWS API Gateway and Lambda functions using Terraform.
