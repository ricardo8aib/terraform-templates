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
