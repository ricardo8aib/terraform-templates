#!/bin/bash

# Get the uri & region
REPO_URI=$(terraform output -raw ecr_repository_uri)
echo $REPO_URI

# Get the tag
REPO_TAG=$(basename $REPO_URI)

echo $REPO_TAG

# Upload the image to ECR
## Retrieve an authentication token and authenticate your Docker client to your registry.
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $REPO_URI

## Build Docker image
docker build -t $REPO_TAG lambda_function/.

## Tag the image
docker tag $REPO_TAG:latest $REPO_URI:latest

## Push the image
docker push $REPO_URI:latest