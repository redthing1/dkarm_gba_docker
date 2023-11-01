# Declare phony targets
.PHONY: help docker-build docker-build-dusk

# Default target is 'help'
default: help

# Automated help command
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# Docker build targets
docker-build: ## Build base docker image
	docker build -f base/Dockerfile --pull -t dkarm_base:local .

docker-build-dusk: ## Build dusk docker image
	docker build -f dusk/Dockerfile --pull -t dkarm_dusk:local .
