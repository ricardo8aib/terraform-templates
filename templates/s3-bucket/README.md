# Simple S3 Bucket

## General description

This template generates an S3 bucket.
The generated bucket has a private ACL by default. This can be changed, however,  in the `terraform.tfvars` file.

## Set up

The `terraform.tfvars` contains basic configurations for the bucket and the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.
The `acl` and `force-destroy` properties can be changed there. The `acl` refers to the canned ACL to apply and the `force-destroy` is a boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error.

## Creating the bucket

This bucket can be initialized using the make command `make create-s3-bucket` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleteing the buucket

This bucket can be deleted using the make command `make destroy-s3-bucket` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```
