MODULE := test_calculator
BLUE='\033[0;34m'
DOCKER_TAG=$(PROJECT_NAME)-$(GIT_HASH)
NC='\033[0m' # No Color

init:
	@ pip install -r requirements.txt

test:
	@pytest

lint:

	@echo "\n${BLUE}Running Pylint against source and test files...${NC}\n"
	@pylint --rcfile=setup.cfg **/*.py

clean:
	rm -rf .pytest_cache .coverage .pytest_cache coverage.xml build dist *.egg-info

publish: build
	@ twine upload dist/* -u {TWINE_USERNAME} -p {TWINE_PASSWORD}
.PHONY: clean test