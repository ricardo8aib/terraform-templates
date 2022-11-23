# S3 Triggered Lambda Function

## General description

This template generates an S3 bucket and a Lambda Function. An Amazon S3 trigger is used to invoke the Lambda Function every time a `.jsonl` (JSON LINES) file with the `/raw` prefix (`raw` folder) is added to the S3 Bucket.

## Set up

The `terraform.tfvars` contains basic configurations for the S3 bucket and the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. The bucket name can be also set there. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the Lambda function and the S3 bucket

This function can be created using the make command `make create-triggered-lambda` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the Lambda function

This instance can be deleted using the make command `make destroy-triggered-lambda` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```

## Tutorials

A tutorial on how to use an Amazon S3 trigger to invoke a Lambda function can be found [here](https://docs.aws.amazon.com/lambda/latest/dg/with-s3-example.html). It also contains instructions on how to test the lambda function from the AWS console.
