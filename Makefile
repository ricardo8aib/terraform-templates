# A Self-Documenting Makefile: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
SHELL = /bin/bash
OS = $(shell uname | tr A-Z a-z)

.PHONY: create-ec2-simple
create-ec2-simple: ## Create infrastructure - Simple EC2
	(cd templates/ec2-simple; terraform init; terraform apply -auto-approve)
	chmod 600 templates/ec2-simple/keys/*.pem

.PHONY: destroy-ec2-simple
destroy-ec2-simple: ## Destroy infrastructure - Simple EC2
	(cd templates/ec2-simple; terraform destroy -auto-approve)
	rm -rf templates/ec2-simple/keys/*.pem

.PHONY: create-ec2-airbyte
create-ec2-airbyte: ## Create infrastructure - airbyte EC2
	(cd templates/ec2-airbyte; terraform init; terraform apply -auto-approve)
	chmod 600 templates/ec2-airbyte/keys/*.pem

.PHONY: destroy-ec2-airbyte
destroy-ec2-airbyte: ## Destroy infrastructure - airbyte EC2
	(cd templates/ec2-airbyte; terraform destroy -auto-approve)
	rm -rf templates/ec2-airbyte/keys/*.pem

.PHONY: create-ec2-airflow
create-ec2-airflow: ## Create infrastructure - airflow EC2
	(cd templates/ec2-airflow; terraform init; terraform apply -auto-approve)
	chmod 600 templates/ec2-airflow/keys/*.pem

.PHONY: destroy-ec2-airflow
destroy-ec2-airflow: ## Destroy infrastructure - airflow EC2
	(cd templates/ec2-airflow; terraform destroy -auto-approve)
	rm -rf templates/ec2-airflow/keys/*.pem

.PHONY: create-s3-bucket
create-s3-bucket: ## Create infrastructure - Simple S3 bucket
	(cd templates/s3-bucket; terraform init; terraform apply -auto-approve)

.PHONY: destroy-s3-bucket
destroy-s3-bucket: ## Destroy infrastructure - Simple S3 bucket
	(cd templates/s3-bucket; terraform destroy -auto-approve)

.PHONY: create-lambda-simple
create-lambda-simple: ## Create infrastructure - Simple S3 lambda
	(cd templates/lambda-simple; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-simple
destroy-lambda-simple: ## Destroy infrastructure - Simple S3 lambda
	(cd templates/lambda-simple; terraform destroy -auto-approve)
	rm -rf templates/lambda-simple/*.zip

.PHONY: create-lambda-s3-triggered
create-lambda-s3-triggered: ## Create infrastructure - S3 triggered lambda
	(cd templates/lambda-s3-triggered; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-s3-triggered
destroy-lambda-s3-triggered: ## Destroy infrastructure - S3 triggered lambda
	(cd templates/lambda-s3-triggered; terraform destroy -auto-approve)
	rm -rf templates/lambda-s3-triggered/*.zip

.PHONY: create-lambda-psycopg2
create-lambda-psycopg2: ## Create infrastructure - Lambda Psycopg2
	(cd templates/lambda-psycopg2; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-psycopg2
destroy-lambda-psycopg2: ## Destroy infrastructure - Lambda Psycopg2
	(cd templates/lambda-psycopg2; terraform destroy -auto-approve)
	rm -rf templates/lambda-psycopg2/*.zip

.PHONY: create-s3-snowflake-stage
create-s3-snowflake-stage: ## Create infrastructure - S3 Snowflake stage bucket
	(cd templates/s3-snowflake-stage; terraform init; terraform apply -auto-approve)

.PHONY: destroy-s3-snowflake-stage
destroy-s3-snowflake-stage: ## Destroy infrastructure - S3 Snowflake stage bucket
	(cd templates/s3-snowflake-stage; terraform destroy -auto-approve)
	rm -rf templates/s3-snowflake-stage/*.zip

.PHONY: create-lambda-pandas
create-lambda-pandas: ## Create infrastructure - Lambda Pandas
	(cd templates/lambda-pandas; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-pandas
destroy-lambda-pandas: ## Destroy infrastructure - Lambda Pandas
	(cd templates/lambda-pandas; terraform destroy -auto-approve)
	rm -rf templates/lambda-pandas/*.zip

.PHONY: create-lambda-custom-layer
create-lambda-custom-layer: ## Create infrastructure - Lambda custom layer
	(cd templates/lambda-custom-layer/layer; sh get_layer_packages.sh)
	(cd templates/lambda-custom-layer; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-custom-layer
destroy-lambda-custom-layer: ## Destroy infrastructure - Lambda custom layer 
	(cd templates/lambda-custom-layer; terraform destroy -auto-approve)
	rm -rf templates/lambda-custom-layer/*.zip
	rm -rf templates/lambda-custom-layer/layer/*.zip
	rm -rf templates/lambda-custom-layer/layer/python

.PHONY: create-dynamo-simple
create-dynamo-simple: ## Create infrastructure - Dynamo simple
	(cd templates/dynamo-simple; terraform init; terraform apply -auto-approve)

.PHONY: destroy-dynamo-simple
destroy-dynamo-simple: ## Destroy infrastructure - Dynamo simple
	(cd templates/dynamo-simple; terraform destroy -auto-approve)

.PHONY: create-lambda-data-diff
create-lambda-data-diff: ## Create infrastructure - Lambda data-diff 
	(cd templates/lambda-data-diff; terraform init; terraform apply -target=aws_ecr_repository.repository -auto-approve)
	(cd templates/lambda-data-diff; bash push_image.sh)
	(cd templates/lambda-data-diff; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-data-diff
destroy-lambda-data-diff: ## Destroy infrastructure - Lambda data-diff
	(cd templates/lambda-data-diff; terraform destroy -auto-approve)

.PHONY: create-using-env-file
create-using-env-file: ## Create infrastructure - Using .env file
	(cd templates/utils-using-env-file; terraform init; terraform apply -auto-approve)

.PHONY: destroy-using-env-file
destroy-using-env-file: ## Destroy infrastructure - Using .env file
	(cd templates/utils-using-env-file; terraform destroy -auto-approve)

.PHONY: create-rds-simple
create-rds-simple: ## Create infrastructure - rds simple
	(cd templates/rds-simple; terraform init; terraform apply -auto-approve)

.PHONY: destroy-rds-simple
destroy-rds-simple: ## Destroy infrastructure - rds simple
	(cd templates/rds-simple; terraform destroy -auto-approve)

.PHONY: create-rds-proxy
create-rds-proxy: ## Create infrastructure - rds proxy
	(cd templates/rds-proxy; terraform init; terraform apply -auto-approve)

.PHONY: destroy-rds-proxy
destroy-rds-proxy: ## Destroy infrastructure - rds proxy
	(cd templates/rds-proxy; terraform destroy -auto-approve)

.PHONY: create-lambda-scheduled
create-lambda-scheduled: ## Create infrastructure - scheduled S3 lambda
	(cd templates/lambda-scheduled; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-scheduled
destroy-lambda-scheduled: ## Destroy infrastructure - scheduled S3 lambda
	(cd templates/lambda-scheduled; terraform destroy -auto-approve)
	rm -rf templates/lambda-scheduled/*.zip

.PHONY: create-lambda-ecr
create-lambda-ecr: ## Create infrastructure - Lambda ecr 
	(cd templates/lambda-ecr; terraform init; terraform apply -target=aws_ecr_repository.repository -auto-approve)
	(cd templates/lambda-ecr; bash push_image.sh)
	(cd templates/lambda-ecr; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-ecr
destroy-lambda-ecr: ## Destroy infrastructure - Lambda ecr
	(cd templates/lambda-ecr; terraform destroy -auto-approve)

.PHONY: create-ecr-and-image
create-ecr-and-image: ## Create infrastructure - ECR & Image
	(cd templates/ecr-and-image; terraform init; terraform apply -auto-approve)
	(cd templates/ecr-and-image; bash push_image.sh)

.PHONY: destroy-ecr-and-image
destroy-ecr-and-image: ## Destroy infrastructure - ECR & Image
	(cd templates/ecr-and-image; terraform destroy -auto-approve)

.PHONY: create-lambda-python-modules
create-lambda-python-modules: ## Create infrastructure - Lambda with python modules
	(cd templates/lambda-python-modules/infrastructure; terraform init; terraform apply -target=aws_ecr_repository.repository -auto-approve)
	(cd templates/lambda-python-modules; bash push_image.sh)
	(cd templates/lambda-python-modules/infrastructure; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-python-modules
destroy-lambda-python-modules: ## Destroy infrastructure - Lambda with python modules
	(cd templates/lambda-python-modules/infrastructure; terraform destroy -auto-approve)

.PHONY: create-lambda-api-gateway
create-lambda-api-gateway: ## Create infrastructure - Lambda API Gateway
	(cd templates/lambda-api-gateway; terraform init; terraform apply -auto-approve)

.PHONY: destroy-lambda-api-gateway
destroy-lambda-api-gateway: ## Destroy infrastructure - Lambda API Gateway
	(cd templates/lambda-api-gateway; terraform destroy -auto-approve)
	rm -rf templates/lambda-api-gateway/*.zip