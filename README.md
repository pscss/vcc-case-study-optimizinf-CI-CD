# Project Overview

This repository demonstrates a complete Python application lifecycle including:

- **Local Development** (Makefile, virtual environment, linting and formatting)
- **Code Quality Enforcement** (Black, isort, Ruff, Mypy, Pytest)
- **Pre-commit Hooks** (`.pre-commit-config.yaml`)
- **Containerization** (Dockerfile)
- **CI/CD Pipeline** (GitHub Actions with `deploy.yaml`)
- **Cloud Deployment** (Google App Engine)

## Table of Contents

- [Local Development](#local-development)
- [Pre-commit Hooks](#pre-commit-hooks)
- [Testing & Code Checks](#testing--code-checks)
- [Docker Container](#docker-container)
- [CI/CD Pipeline](#cicd-pipeline)
  - [Feature Branch Flow](#feature-branch-flow)
  - [Pull Request Flow](#pull-request-flow)
  - [Manual Deployment](#manual-deployment)
- [Branch Protections](#branch-protections)

## Local Development

### Clone the Repository
```bash
git clone https://github.com/your-organization/your-repo.git
cd your-repo
```

### Set Up the Environment
```bash
make setup
```
This command:
- Creates a Python virtual environment (`.venv`).
- Installs dependencies from `requirements.txt`.
- Installs and configures pre-commit hooks.

### Start the Local Server
```bash
make dev
```
Runs a Flask development server at `http://127.0.0.1:5000`.

## Pre-commit Hooks

Configured in `.pre-commit-config.yaml`:
- Checks for trailing whitespace, file endings, YAML issues, and large files.
- Formats code with Black and sorts imports with isort.
- Lints code with Ruff.
- Type checks with Mypy.

Run manually:
```bash
pre-commit run --all-files
```

## Testing & Code Checks

Makefile commands for code quality:
- **Lint** (Ruff): `make lint`
- **Format** (Black & isort): `make format`
- **Type Check** (Mypy): `make typecheck`
- **Test** (Pytest): `make test`
- **All Checks**: `make check`

## Docker Container

### Build the Docker Image
```bash
docker build -t myapp:local .
```

### Run the Docker Container
```bash
docker run -p 8080:8080 myapp:local
```

Accessible at `http://localhost:8080`.

## CI/CD Pipeline

Defined in `.github/workflows/deploy.yaml`:

### Feature Branch Flow
Triggered by push to branches other than `dev` and `main`:
- Checkout code, install dependencies, run linting, formatting, and tests.

### Pull Request Flow
Triggered by PRs to `dev` or `main`:
- Build Docker image (`dev` or `prod` tags).
- Authenticate and push image to Google Container Registry.

### Manual Deployment
Triggered manually in GitHub Actions:
1. Choose `dev`, `stage`, or `prod`.
2. Authenticate to Google Cloud.
3. Deploy Docker image to App Engine.

## Branch Protections

Enforce protections on `dev` and `main`:
- Require pull requests.
- Require passing CI checks.
- Restrict direct pushes.
