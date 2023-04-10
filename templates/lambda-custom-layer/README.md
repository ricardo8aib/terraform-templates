# Lambda Function with custom layer

## General description

This template uses a `requirements.txt` file to generate a custom layer, and a Lambda function that can use that layer.

## Set up

The `terraform.tfvars` contains basic configurations for the lambda and the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

### Important *

Users can add more libraries and specify the versions by modifying the [requirements.txt](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/lambda-custom-layer/layer/requirements.txt) file. The [get_layer_packages.sh](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/lambda-custom-layer/layer/get_layer_packages.sh) script creates the layer using Docker to get Lambda-compatible versions of libraries from the [requirements.txt](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/lambda-custom-layer/layer/requirements.txt) file. This template uses the `lambci/lambda:build-python3.8` public docker image. For more info, check the references.

## Creating the Lambda function

This function can be created using the make command `make create-lambda-custom-layer` from the root directory of this repo or by running the following command within this directory:

``` bash
(cd layer; sh get_layer_packages.sh)
terraform init
terraform apply -auto-approve
```

## Deleting the Lambda function

This function can be deleted using the make command `make destroy-lambda-custom-layer` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```

## References

- [Creating New AWS Lambda Layer For Python Pandas Library](https://medium.com/@qtangs/creating-new-aws-lambda-layer-for-python-pandas-library-348b126e9f3e)
- [How to lightweight your Python AWS Lambda functions with AWS Lambda Layer, Docker, and Terraform](https://medium.com/wescale/how-to-lightweight-your-python-aws-lambda-functions-with-aws-lambda-layer-docker-and-terraform-b48602e76e8b)
- [Resource: aws_lambda_layer_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version)
