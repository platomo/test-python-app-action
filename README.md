# Test Python

## Description

The `Test Python` GitHub Action automates testing workflows for Python applications.
It specifies the inputs, key steps, and configurations needed to execute tests,
perform linting, check static types, and create coverage reports. This action
streamlines development by ensuring code quality and robustness in Python projects.

## Inputs

| Name              | Description                                                    | Required | Default |
|-------------------|----------------------------------------------------------------|----------|---------|
| `package-path`    | Specifies the Python package directory for coverage reporting. | Yes      | None    |
| `py-version`      | Version of Python used to execute the tests.                   | Yes      | None    |
| `ffmpeg-required` | Determines if FFMPEG installation is needed.                   | No       | false   |
| `test-path`       | Directory containing the test files.                           | No       | tests/  |

## Usage

Use this action by creating a workflow file, for example: `.github/workflows/test.yml`:

```yaml
name: Test

on:
  # Run tests each time a PR is opened or changed.
  # Allow other Workflows (e.g., build workflows) to call this workflow.
  pull_request:
  workflow_call:

jobs:
  test:
    name: Execute tests across various operating systems and Python versions.
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

This action requires access to the source code to execute tests, linting, and type
analysis.
