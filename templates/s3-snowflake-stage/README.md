# S3 Bucket for Snowflake Stage

## General description

This template generates an S3 bucket. And the IAM role and policy required to let Snowflake access the bucket.
The generated bucket has a private ACL by default. This can be changed, however,  in the `terraform.tfvars` file.

## Set up

The `terraform.tfvars` contains basic configurations for the bucket and the AWS profile. The `profile` variable indicates terraform which AWS profile should be used to deploy the infrastructure. By default, terraform checks the AWS profiles in `~/.aws/credentials`.
The `acl` and `force-destroy` properties can be changed there. The `acl` refers to the canned ACL to apply and the `force-destroy` is a boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error.  
The `aws_account_id` refers to the AWS account ID that can be found in the upper right corner of the AWS console. It should look like `559303431033`.

### Important *

The resources created in this Terraform module only apply to AWS. To have a functional stage other steps must be followed and can be found in the `further steps` section.

## Creating the bucket

This bucket can be initialized using the make command `make create-s3-snowflake-stage` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform init
terraform apply -auto-approve
```

## Deleting the bucket

This bucket can be deleted using the make command `make create-s3-snowflake-stage` from the root directory of this repo or by running the following command within this directory:

``` bash
terraform destroy -auto-approve
```

## Further steps

This module creates the AWS S3 bucket that will serve as Stage and the role that will allow Snowflake access to the data stored in the stage. However, some steps must be executed within Snowflake first.

1. Create a `Storage Integration`

    An external storage integration will link the `IAM role` that was created before with Snowflake.  
    With the proper Snowflake permissions execute the following code (Make sure to use the previously created bucket's ARN):

    ```SQL
    CREATE OR REPLACE STORAGE INTEGRATION terraform_templates_storage_integration
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = S3
    ENABLED = TRUE
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::559303431033:role/terraform-templates-snowflake-s3-role'
    STORAGE_ALLOWED_LOCATIONS = ('s3://terraform-templates-snowflake-s3-bucket');
    ```

2. Check the `STORAGE_AWS_IAM_USER_ARN` and the `STORAGE_AWS_EXTERNAL_ID`

    With the proper Snowflake permissions execute the following code:

    ```SQL
    DESC integration terraform_templates_storage_integration;
    ```

    In the resulting table, check and copy the `property_value` of `STORAGE_AWS_IAM_USER_ARN` and `STORAGE_AWS_EXTERNAL_ID`.
    The `STORAGE_AWS_IAM_USER_ARN` should look like `arn:aws:iam::090302819344:user/whp20000-s` and the `STORAGE_AWS_EXTERNAL_ID` should look like `DUB81018_SFCRole=2_jnslNPeZg4ENN7/dI0e3m3cuS80=`.

3. Configure the IAM Role Trust relationship

    This step requires going to the AWS IAM console, selecting the previously created role, and editing the `Trust Relationship` with the `STORAGE_AWS_IAM_USER_ARN` and `STORAGE_AWS_EXTERNAL_ID` values obtained from the previous step.

    ```JSON
        {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "AWS": "<STORAGE_AWS_IAM_USER_ARN>"
        },
        "Action": "sts:AssumeRole",
        "Condition": {
            "StringEquals": {
            "sts:ExternalId": "<STORAGE_AWS_EXTERNAL_ID>"
            }
        }
        }
    ]
    }
    ```

4. Create a Snowflake stage

    Finally, create a Snowflake stage with the following command:

    ```SQL
        CREATE OR REPLACE stage terraform_templates_stage   
        URL = ('s3://terraform-templates-snowflake-s3-bucket/')   
        STORAGE_INTEGRATION = terraform_templates_storage_integration;
    ```

## Tutorials

The tutorial used for the previous instructions can be found here [here](https://medium.com/plumbersofdatascience/how-to-ingest-data-from-s3-to-snowflake-with-snowpipe-7729f94d1797). It also contains instructions on setting up Snowpipe using the created stage.
