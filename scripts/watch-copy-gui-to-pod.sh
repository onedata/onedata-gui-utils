#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COPY_GUI_TO_POD_SCRIPT=$SCRIPT_DIR/copy-gui-to-pod.sh
$COPY_GUI_TO_POD_SCRIPT $1 $2
fswatch -o -l 2 --event=Updated ./rel/assets ./rel/assets/scripts/custom-frontpage-integration.js | (while read; do $COPY_GUI_TO_POD_SCRIPT $1 $2; done)
