# A Self-Documenting Makefile: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
SHELL = /bin/bash
OS = $(shell uname | tr A-Z a-z)

.PHONY: create-simple-ec2
create-simple-ec2: ## Create infrastructure - Simple EC2
	(cd templates/simple-ec2; terraform init; terraform apply -auto-approve)
	chmod 600 templates/simple-ec2/keys/*.pem

.PHONY: destroy-simple-ec2
destroy-simple-ec2: ## Destroy infrastructure - Simple EC2
	(cd templates/simple-ec2; terraform destroy -auto-approve)
	rm -rf templates/simple-ec2/keys/*.pem

.PHONY: create-airbyte-ec2
create-airbyte-ec2: ## Create infrastructure - airbyte EC2
	(cd templates/airbyte-ec2; terraform init; terraform apply -auto-approve)
	chmod 600 templates/airbyte-ec2/keys/*.pem

.PHONY: destroy-airbyte-ec2
destroy-airbyte-ec2: ## Destroy infrastructure - airbyte EC2
	(cd templates/airbyte-ec2; terraform destroy -auto-approve)
	rm -rf templates/airbyte-ec2/keys/*.pem

.PHONY: create-airflow-ec2
create-airflow-ec2: ## Create infrastructure - airflow EC2
	(cd templates/airflow-ec2; terraform init; terraform apply -auto-approve)
	chmod 600 templates/airflow-ec2/keys/*.pem

.PHONY: destroy-airflow-ec2
destroy-airflow-ec2: ## Destroy infrastructure - airflow EC2
	(cd templates/airflow-ec2; terraform destroy -auto-approve)
	rm -rf templates/airflow-ec2/keys/*.pem

.PHONY: create-s3-bucket
create-s3-bucket: ## Create infrastructure - Simple S3 bucket
	(cd templates/s3-bucket; terraform init; terraform apply -auto-approve)

.PHONY: destroy-s3-bucket
destroy-s3-bucket: ## Destroy infrastructure - Simple S3 bucket
	(cd templates/s3-bucket; terraform destroy -auto-approve)

.PHONY: create-simple-lambda
create-simple-lambda: ## Create infrastructure - Simple S3 lambda
	(cd templates/simple-lambda; terraform init; terraform apply -auto-approve)

.PHONY: destroy-simple-lambda
destroy-simple-lambda: ## Destroy infrastructure - Simple S3 lambda
	(cd templates/simple-lambda; terraform destroy -auto-approve)
	rm -rf templates/simple-lambda/*.zip
