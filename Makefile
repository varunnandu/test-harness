MODULE := test_calculator
BLUE='\033[0;34m'
DOCKER_TAG=$(PROJECT_NAME)-$(GIT_HASH)
NC='\033[0m' # No Color

init:
	@ pip install -r requirements.txt

test:
	@echo "\n${BLUE} Creating a report .coverage file"
	@coverage run -m pytest
	@echo "\n${BLUE} Reading the report .coverage file"
	@coverage report -m --rcfile=setup.cfg

lint:

	@echo "\n${BLUE}Running Pylint against source and test files...${NC}\n"
	@pylint --rcfile=setup.cfg **/*.py

clean:
	rm -rf .pytest_cache .coverage .pytest_cache coverage.xml build dist *.egg-info

build:
	@ twine upload dist/* -r https://nexus.ennate.build/repository/pypi/
.PHONY: clean test