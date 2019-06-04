# !/bin/bash
# ./gui-release-19.06.sh oz-worker onezone-gui https://bamboo.onedata.org/browse/VFS-OZG72-4 release/19.02.0-beta1 VFS-5476 "Refactoring of token/origin endpoints and unfied GUI URL" plgjliput

BACKEND_NAME=$1
FRONTEND_NAME=$2
BUILD_URL=$3
BACKEND_BRANCH=$4
FRONTEND_TASK=$5
FRONTEND_CHANGELOG=$6
BAMBOO_USER=$7

cd /tmp || exit $?
rm -rf $BACKEND_NAME || exit $?
git clone ssh://git@git.plgrid.pl:7999/vfs/${BACKEND_NAME}.git || exit $?
cd $BACKEND_NAME || exit $?
git checkout $BACKEND_BRANCH || exit $?
export BACKEND_UPDATE_BRANCH="feature/${FRONTEND_TASK}-gui-update"
git checkout -b ${BACKEND_UPDATE_BRANCH} || exit $?
curl -u $BAMBOO_USER $BUILD_URL/artifact/shared/gui-config.sh/gui-config.sh > gui-config.sh
git add gui-config.sh
git commit -m "${FRONTEND_TASK} GUI update" -m "${FRONTEND_CHANGELOG}"
git push -u origin ${BACKEND_UPDATE_BRANCH}
