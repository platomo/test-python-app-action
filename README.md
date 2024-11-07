# Test Python

This GitHub Action runs tests for Python applications and provides a reusable testing environment.

## Description

This Action runs tests for Python projects that can be executed on a specified operating system and Python version. It also supports optional installation of FFMPEG and setting up caching for dependencies.

## Inputs

| Name              | Description                                       | Required | Default |
| ----------------- | ------------------------------------------------- | -------- | ------- |
| `test_path`       | The path to the files or directories to be tested | Yes      | None    |
| `os`              | The operating system on which to run the tests    | Yes      | None    |
| `py-version`      | The Python version to use for the tests           | Yes      | None    |
| `ffmpeg-required` | Indicates whether FFMPEG should be installed      | Yes      | None    |

## Usage

Create a workflow file (e.g., `.github/workflows/test.yml`) and use this Action as follows:

```yaml
name: Test Python Application

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ${{ inputs.os }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Test Python
        uses: platomo/test-python-app-action@main
        with:
          test_path: "src/"
          os: "ubuntu-latest"
          py-version: "3.9"
          ffmpeg-required: true
```

## Workflow Steps

1. **Checkout Repository**: Checks out the code from the repository.
2. **Install FFMPEG** (optional): Installs FFMPEG if `ffmpeg-required` is set to `true`.
3. **Set up Python**: Configures the specified Python version and enables `pip` caching.
4. **Install Python Dependencies**: Installs required dependencies based on `requirements.txt` and `requirements-dev.txt` files (if available).
5. **Linting**: Checks the code format with `flake8`.
6. **Static Type Checking**: Performs type checking with `mypy`.
7. **Run Tests**: Executes tests using `pytest` and generates coverage for the specified `test_path`.

## Required Permissions

This Action requires access to the source code to perform tests, linting, and type checking.
