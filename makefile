SHELL := /bin/bash
VENV ?= .venv
PYTHON ?= python3

.DEFAULT_GOAL := help

help:
	@echo "Usage:"
	@echo "  make <target>"
	@echo
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: install pre-commit-install ## Create venv, install deps, install pre-commit
	@echo "Development environment is ready."

install: ## Create .venv and install dependencies
	test -d $(VENV) || $(PYTHON) -m venv $(VENV)
	source $(VENV)/bin/activate && pip install --upgrade pip
	source $(VENV)/bin/activate && pip install -r requirements.txt

pre-commit-install: ## Install and activate pre-commit hooks
	source $(VENV)/bin/activate && pre-commit install

dev: setup ## Run local Flask app
	source $(VENV)/bin/activate && flask run

lint: ## Lint code using Ruff
	source $(VENV)/bin/activate && ruff check .

format: ## Auto-format code with Black & isort
	source $(VENV)/bin/activate && black . && isort .

typecheck: ## Static type checks using Mypy
	source $(VENV)/bin/activate && mypy .

test: ## Run tests with pytest
	source $(VENV)/bin/activate && pytest --maxfail=1 --disable-warnings -q

check: lint typecheck test ## Lint, type-check, then test
	@echo "All checks passed."
