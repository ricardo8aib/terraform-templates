# Simple EC2 Instance

## General description

This template generates an EC2 instance.
The generated instance has a security group that allows access and egress from all ports. This can be changed, however, for security purposes in the `main.tf` file.

The instance install `docker` and `docker-compose` during the start up. Other tools
can be installed during the start up by modifying the `user_data` param from the `ec2_instance` resource in the `main.tf` file.

## Set up

The `terraform.tfvars` contains basic configurations for the instance and the AWS profile. The `profile` varialbe indicates terraform which AWS profile should be used to deploy the infrastructure. By defult, terraform checks the AWS profiles in `~/.aws/credentials`.
The `AMI`, `instance type` and `instance size` can be also set there. This template uses by default a `t2.small` machine with a `ami-052efd3df9dad4825` AMI.
