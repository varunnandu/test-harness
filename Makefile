MODULE := test_calculator
BLUE='\033[0;34m'
DOCKER_TAG=$(PROJECT_NAME)-$(GIT_HASH)
NC='\033[0m' # No Color

init:
	@ pip install --index-url https://nexus.securetempus.com/repository/pypi/simple -r requirements.txt

run:
	@python -m example

test:
	@pytest

lint:

	@echo "\n${BLUE} Running Black Code formatter"
	@black ${MODULE}/ settings/ dp_types/ -l 99
	@echo "\n${BLUE}Running Pylint against source and test files...${NC}\n"
	@pylint --rcfile=setup.cfg **/*.py
	@echo "\n${BLUE}Running Flake8 against source and test files...${NC}\n"
	@flake8
	@echo "\n${BLUE}Running Bandit against source files...${NC}\n"
	@bandit -r --ini setup.cfg

clean:
	rm -rf .pytest_cache .coverage .pytest_cache coverage.xml build dist *.egg-info

build-docker: clean
	@ docker build -f docker/Dockerfile . -t $(DOCKER_TAG)
	@ docker run $(DOCKER_TAG):latest

publish: build
	@ python -m twine upload -r tempus $(shell ls -1 dist/*.whl | head -1) --config-file .pypirc

publish-docker:
	@echo
	@echo --- Publish pypi-internal From Container ---
	@docker build -f docker/publish.Dockerfile -t publish_$(PROJECT_NAME):$(GIT_HASH) --force-rm=true --no-cache=true --pull=true --rm=true .
	@docker run publish_$(PROJECT_NAME):$(GIT_HASH)

.PHONY: clean test