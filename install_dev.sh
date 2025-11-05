#!/bin/bash
set -e
echo "Install development environment."

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
	SOURCE=$(readlink "$SOURCE")
	[[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)

set -e
echo "Install python_template."

echo "$DIR"
cd "$DIR" || exit

WORKING_DIR=$(pwd)
VENV="$WORKING_DIR"/.venv
PYTHON="$VENV"/bin/python
PRE_COMMIT="$VENV"/bin/pre-commit

python3.11 -m venv "$VENV"

# Install uv
$PYTHON -m pip install uv

# Use uv to install dependencies
$PYTHON -m uv pip install -r requirements-dev.txt
$PRE_COMMIT install --install-hooks
