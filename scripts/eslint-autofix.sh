#!/bin/bash
# This script should be invoked from source dir, eg. "src", where is the Ember's project
# root with fetched dependencies (node_modules).

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

${SCRIPT_DIR}/eslint-all.sh --fix
