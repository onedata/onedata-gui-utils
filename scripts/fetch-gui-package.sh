#!/bin/bash
# ./fetch-gui-package onepanel-gui:ID_SHA256P-a929677647-6163482d62

IMG_NAME=$1
TARGET_DIR=${2:-.}
TARGET_PATH=${TARGET_DIR}/gui_static.tar.gz

[ -z "$IMG_NAME" ] && { echo "Error: provide GUI docker image name."; exit 1; }

CONTAINER_ID=`docker run --detach docker.onedata.org/${IMG_NAME} /bin/true`
docker cp -L ${CONTAINER_ID}:/var/www/html/gui_static.tar.gz ${TARGET_PATH}
docker rm -f ${CONTAINER_ID} > /dev/null
