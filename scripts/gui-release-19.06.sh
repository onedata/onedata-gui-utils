#!/bin/bash
# ./gui-release-19.06.sh oz-worker onezone-gui https://bamboo.onedata.org/browse/VFS-OZG72-4 release/19.02.0-beta1 VFS-5476 "Refactoring of token/origin endpoints and unfied GUI URL" plgjliput

function print_error {
  printf "\e[31mERROR: %s\e[0m\n" "$1" >&2
  exit 1
}

BACKEND_NAME=$1
FRONTEND_NAME=$2
BUILD_URL=$3
BACKEND_BRANCH=$4
FRONTEND_TASK=$5
FRONTEND_CHANGELOG=$6
BAMBOO_USER=$7

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
GUI_CONFIG_FILENAME="gui-image.conf"
BACKEND_UPDATE_BRANCH="feature/${FRONTEND_TASK}-gui-update"

cd /tmp || exit $?
rm -rf $BACKEND_NAME || exit $?
git clone ssh://git@git.onedata.org:7999/vfs/${BACKEND_NAME}.git || exit $?
cd $BACKEND_NAME || exit $?
git checkout $BACKEND_BRANCH || exit $?
git checkout -b ${BACKEND_UPDATE_BRANCH} || exit $?

# Download gui-image.conf do backend project and get the image tag for further use
curl -v -f -u $BAMBOO_USER ${BUILD_URL}/artifact/shared/${GUI_CONFIG_FILENAME}/${GUI_CONFIG_FILENAME} > ${GUI_CONFIG_FILENAME}
CURL_EXITCODE=$?
if [ $CURL_EXITCODE -ne 0 ]
then
  print_error "Could not fetch gui-image.conf from Bamboo"
  exit $CURL_EXITCODE
fi
FRONTEND_IMAGE_TAG=`cat ${GUI_CONFIG_FILENAME} | grep 'IMAGE_TAG=' | sed -n  's/IMAGE_TAG="\(.*\)"/\1/p'`
echo "Image tag: $FRONTEND_IMAGE_TAG"
if [ "$FRONTEND_IMAGE_TAG" == "" ]
then
  print_error "Could not parse gui-image.conf"
  exit 1
fi

# Tag and publish docker image to Docker Hub
echo "Login to docker.onedata.org"
docker login docker.onedata.org
echo "Login to DockerHub"
docker login
${SCRIPT_DIR}/docker-tag-publish.py docker.onedata.org/${FRONTEND_NAME}:${FRONTEND_IMAGE_TAG}
PUBLISH_EXITCODE=$?
echo publish exitcode $PUBLISH_EXITCODE
if [ $PUBLISH_EXITCODE -ne 0 ]
then
  print_error "Could not publish docker image"
  exit $PUBLISH_EXITCODE
fi

# Commit gui-image.conf to backend project and give a link to create pull request
git add ${GUI_CONFIG_FILENAME} || exit $?
git commit -m "${FRONTEND_TASK} GUI update" -m "${FRONTEND_CHANGELOG}" || exit $?
git push --force -u origin ${BACKEND_UPDATE_BRANCH} || exit $?
echo "-----"
echo "https://git.onedata.org/projects/VFS/repos/${BACKEND_NAME}/compare/commits?targetBranch=refs%2Fheads%2F${BACKEND_BRANCH}&sourceBranch=refs%2Fheads%2F${BACKEND_UPDATE_BRANCH}"
