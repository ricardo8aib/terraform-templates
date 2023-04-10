# Using a .env file

## General description

This template generates an S3 bucket using a `.env` file from this folder, and it is intended to be a guide on how to use a `.env` file to set up terraform parameters. To recreate the process create a new `.env` file in this folder based on the [.env.sampe file](https://github.com/ricardo8aib/terraform-templates/tree/main/templates/utils-using-env-file/.env.sample).

## Set up

The `variables.tf` file loads the basic configurations for the bucket and the AWS profile from an `.env` file in this folder:

``` tf
locals {
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
}
```

``` txt
# AWS Settings
PROFILE=profile
PROJECT=terraform-templates
REGION=us-east-1
ACL=private
FORCE_DESTROY=true
BUCKET_NAME=terraform-templates-using-env-bucket
```

 The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.

## Creating the bucket

This bucket can be initialized using the make command `make create-using-env-file` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the bucket

This bucket can be deleted using the make command `destroy-using-env-file` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```
