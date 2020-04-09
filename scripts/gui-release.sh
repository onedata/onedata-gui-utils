#!/bin/bash

# Alias for current version of release script

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

${SCRIPT_DIR}/gui-release-19.06.sh $@
