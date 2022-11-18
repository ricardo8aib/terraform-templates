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