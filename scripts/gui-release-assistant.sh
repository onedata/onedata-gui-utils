#!/bin/bash

# Copyright (C) 2026 Onedata (onedata.org)
# Author: Jakub Liput
#
# A wrapper for gui-release script for releasing (updating image) multiple GUIs at once
# for the same issue and target branch.
# Review the file before usage and set variables marked as "uncommed and edit".

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

## Example: Set the issue - uncomment and edit!
# export ISSUE=VFS-13350

export BACKEND_BRANCH="develop"

## Example: custom backend branch
# export BACKEND_BRANCH="feature/VFS-13176-upload-replace-chosen"

## Example: commit messages - uncomment and edit at least one of them
# export OP_CHANGE="Added support for showing error for additional download start failures"
# export OZ_CHANGE="Fixed docs and API links for new homepage"
# export PANEL_CHANGE="Fixed docs and API links for new homepage"

## Example: Bamboo build URLs - uncomment and edit at least one of them
# export OP_BUILD=https://bamboo.onedata.org/browse/VFS-OPGU697-5
# export OZ_BUILD=https://bamboo.onedata.org/browse/VFS-OZG671-6
# export PANEL_BUILD=https://bamboo.onedata.org/browse/VFS-OPG554-7

export SCRIPT=${SCRIPT_DIR}/gui-release.sh

echo "Bamboo password:"
read -s BAMBOO_PASSWORD
export BAMBOO_PASSWORD=$BAMBOO_PASSWORD

# Example: run release script for each GUI component - uncomment and edit at least one of them
# ${SCRIPT} op-worker oneprovider-gui ${OP_BUILD} ${BACKEND_BRANCH} ${ISSUE} "${OP_CHANGE}" plgjliput
# ${SCRIPT} oz-worker onezone-gui ${OZ_BUILD} ${BACKEND_BRANCH} ${ISSUE} "${OZ_CHANGE}" plgjliput
# ${SCRIPT} onepanel onepanel-gui ${PANEL_BUILD} ${BACKEND_BRANCH} ${ISSUE} "${PANEL_CHANGE}" plgjliput