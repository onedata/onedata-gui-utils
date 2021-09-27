#!/bin/bash
if [ -z "$1" ]; then
  GUI_TYPE=oz-worker
else
  GUI_TYPE=$1
fi
if [ -z "$2" ]; then
  BUILDS_PATH=/Users/kliput/Onedata/one-env/src-dev
else
  BUILDS_PATH=$2
fi
STATIC_PATH=`~/Onedata/onedata-gui-utils/scripts/gui-build-path.sh ${GUI_TYPE} ${BUILDS_PATH}`
# STATIC_PATH=/Users/kliput/Onedata/one-env/src-dev/oz-worker/_build/default/rel/oz_worker/etc/gui_static/ozw/20142ad20422adab65630cd6b1af4dfbd5433d43e3a718b1a81917d008350dc9
echo "Will copy to: ${STATIC_PATH}"
echo "----"
kubectl exec dev-onezone-0 -- rm -rf ${STATIC_PATH}
kubectl cp rel dev-onezone-0:${STATIC_PATH}
kubectl exec dev-onezone-0 -- sh -c "cd ${STATIC_PATH} && ln -s index.html i"
kubectl exec dev-onezone-0 -- ls -l ${STATIC_PATH}
echo "----" $(date) "----"
