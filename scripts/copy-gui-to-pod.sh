#!/bin/bash

# Copyright (c) 2026 Onedata (onedata.org)
# Author: Jakub Liput
#
# This script copies the GUI static files to a pod. It takes two optional arguments:
# 1. GUI_TYPE: The type of GUI to copy (default: oz-worker)
# 2. BUILDS_PATH: The path to the builds directory (default: ~/Onedata/one-env/src-dev)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -z "$1" ]; then
  GUI_TYPE=oz-worker
else
  GUI_TYPE=$1
fi
if [ -z "$2" ]; then
  BUILDS_PATH=~/Onedata/one-env/src-dev
else
  BUILDS_PATH=$2
fi

## Default: support for onezone, oneprovider and unified cluster GUI (onepanel) on
## source-based deployment. For more info, see gui-build-path.sh script.
POD_NAME=dev-onezone-0
STATIC_PATH=`${SCRIPT_DIR}/gui-build-path.sh ${GUI_TYPE} ${BUILDS_PATH}`

## Example: paths on image-based deployment (non-source)
# STATIC_PATH=/volumes/persistence/etc/oz_worker/gui_static/onp/ce4d84f5cadb77a72416c8a15df25d88ch1e7e
# STATIC_PATH=/volumes/persistence/etc/oz_panel/gui_static
# STATIC_PATH=/volumes/persistence/etc/oz_worker/gui_static/ozw/efe2e014d16293862875d2c02c774e68fcbec1c2835c54b9abfe046b56e218a1
# STATIC_PATH=/volumes/persistence/etc/oz_worker/gui_static/opw/79f4ea906e87bbb046bf5998a226e2fa248687bf2aa4ac18b31b3934a7150912

## Example: emergency panel for oneprovider-krakow on image-based deployment (non-source)
# POD_NAME=dev-oneprovider-krakow-0
# STATIC_PATH=/volumes/persistence/etc/op_panel/gui_static

## Example: emergency panel for oneprovider-krakow on source-based deployment
# POD_NAME=dev-oneprovider-krakow-0
# STATIC_PATH=${BUILDS_PATH}/onepanel/_build/default/rel/op_panel/etc/gui_static

echo "Will copy to: ${STATIC_PATH}"
echo "----"
kubectl exec ${POD_NAME} -- rm -rf ${STATIC_PATH}
kubectl cp rel ${POD_NAME}:${STATIC_PATH}
kubectl exec ${POD_NAME} -- sh -c "cd ${STATIC_PATH} && ln -s index.html i"
kubectl exec ${POD_NAME} -- ls -l ${STATIC_PATH}
echo "----" $(date) "----"
