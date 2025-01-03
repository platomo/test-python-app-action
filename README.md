# Test Python

## Description

The `Test Python` GitHub Action is designed to automate testing workflows for Python
applications. It defines the inputs, required steps, and configurations needed to
run tests, perform linting, static type checking, and generate coverage reports.
This action helps streamline development processes by ensuring code quality and
robustness in Python projects.

## Inputs

| Name              | Description                                        | Required | Default |
|-------------------|----------------------------------------------------|----------|---------|
| `package-path`    | Path to the Python package for coverage reporting. | Yes      | None    |
| `py-version`      | Python version to run the tests on.                | Yes      | None    |
| `ffmpeg-required` | Indicates whether FFMPEG should be installed.      | No       | false   |
| `test-path`       | Path to the test files.                            | No       | tests/  |

## Usage

To use this action, create a workflow file (e.g., `.github/workflows/test.yml`):

```yaml
name: Test

on:
  # Run tests each time a PR is opened or changed.
  # Allow other Workflows (e.g., build workflows) to call this workflow.
  pull_request:
  workflow_call:

jobs:
  test:
    name: Run Python tests on multiple OS and Python versions.
    strategy:
      matrix:
        os: [ ubuntu-latest, windows-latest ]
        py: [ "3.11", "3.12" ]
      fail-fast: true
    runs-on: ${{ matrix.os }}
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      - name: Run Python Tests
        uses: platomo/test-python-app-action@v1
        timeout-minutes: 60
        with:
          py-version: ${{ matrix.py }}
          package-path: my-package-name
          test-path: tests
          ffmpeg-required: true
```

## Required Permissions

This Action requires access to the source code to perform tests, linting, and type
checking.
