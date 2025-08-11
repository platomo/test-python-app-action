# 🛠️ GitHub Action: Test Python Package

## 📄 Description

The `Test Python Package` GitHub Action automates testing workflows for Python
applications.
It specifies the inputs, key steps, and configurations needed to execute tests,
perform linting, check static types, and create coverage reports. This action
streamlines development by ensuring code quality and robustness in Python projects.
The action requires a pyproject.toml file to be present in the repository.

## ⚙️ Inputs

| Name              | Description                                                    | Required | Default  |
| ----------------- | -------------------------------------------------------------- | :------: | :------: |
| `package-path`    | Specifies the Python package directory for coverage reporting. |   Yes    |    -     |
| `py-version`      | Version of Python used to execute the tests.                   |   Yes    |    -     |
| `ffmpeg-required` | Determines if FFMPEG installation is needed.                   |    No    | `false`  |
| `test-path`       | Directory containing the test files.                           |    No    | `tests/` |

## 📦 Usage Example

Use this action by creating a workflow file, for example: `.github/workflows/test.yml`:

```yaml
---
name: Test

on:
  # Run tests each time a PR is opened or changed.
  # Allow other Workflows (e.g., build workflows) to call this workflow.
  pull_request:
  workflow_call:

permissions: read-all

jobs:
  test:
    name: Execute tests across various operating systems and Python versions.
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        py: ["3.11", "3.12"]
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

## 🆕 Create a new release

To create a new release of the action, use the GitHub release function and create a new
tag according to semantic version requirements (vX.Y.Z).
The GitHub workflow `major-release-tag.yml` will automatically move the major version
tag to the new release.

## ⚖️ License

GNU GENERAL PUBLIC LICENSE Version 3
