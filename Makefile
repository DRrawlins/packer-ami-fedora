.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

validate: ## Validates the template file to ensure there are no glaring errors
	@packer validate template.json

build-aws-imp: validate ## Builds on the current machine via Virtualbox
	@packer build --force template.json

build-aws-ebs: validate ## Builds on the current machine via Virtualbox
	@packer build --force template-ebs.json
