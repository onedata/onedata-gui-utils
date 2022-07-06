#!/bin/bash

TYPE=$1
PREFIX=$2

if [ -z "$TYPE" ]; then exit 1; fi
if [ -z "$PREFIX" ]; then exit 2; fi

FILE_NAME="gui_static.tar.gz"

if [[ "$TYPE" == o?-panel ]]; then
  REPO_DIR="onepanel"
  TYPE_ABBREV=`echo $TYPE | head -c 2`
  SHA=`shasum -a 256 $PREFIX/$REPO_DIR/_build/default/rel/${TYPE_ABBREV}_panel/data/$FILE_NAME | cut -d ' ' -f 1`
elif [[ "$TYPE" == oz-worker ]]; then
  REPO_DIR="oz-worker"
  SHA=`shasum -a 256 $PREFIX/$REPO_DIR/_build/default/lib/ozw_$FILE_NAME | cut -d ' ' -f 1`
elif [[ "$TYPE" == harvester ]]; then
  REPO_DIR="oz-worker"
  SHA=`shasum -a 256 $PREFIX/$REPO_DIR/_build/default/lib/hrv_$FILE_NAME | cut -d ' ' -f 1`
elif [[ "$TYPE" == oz-panel-emergency ]]; then
  # checksum is not used for emergency panel
  true
else
  REPO_DIR=$TYPE
  SHA=`shasum -a 256 $PREFIX/$REPO_DIR/_build/default/lib/$FILE_NAME | cut -d ' ' -f 1`
fi

case "$TYPE" in
  oz-worker)
    GUI_DIR="ozw"
    ;;
  op-worker)
    GUI_DIR="opw"
    ;;
  op-panel)
    GUI_DIR="onp"
    ;;
  oz-panel)
    GUI_DIR="onp"
    ;;
  harvester)
    GUI_DIR="hrv"
    ;;
  oz-panel-emergency)
    echo "$PREFIX/onepanel/_build/default/rel/oz_panel/etc/gui_static"
    exit 0
    ;;
  *)
    exit 3
esac

echo "$PREFIX/oz-worker/_build/default/rel/oz_worker/etc/gui_static/$GUI_DIR/$SHA"
