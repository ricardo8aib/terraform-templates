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

.PHONY: extract-data
extract-data: ## Extract data
	poetry run python extraction/extraction.py