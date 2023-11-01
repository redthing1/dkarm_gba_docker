help:
	@echo "make docker-build"
	@echo "       build base docker image"
	@echo "make docker-build-dusk"
	@echo "       buld dusk docker image"

.PHONY: docker-build
docker-build:
	docker build -f base/Dockerfile --pull -t dkarm_base:local .

.PHONY: docker-build-dusk
docker-build-dusk:
	docker build -f dusk/Dockerfile --pull -t dkarm_dusk:local .
