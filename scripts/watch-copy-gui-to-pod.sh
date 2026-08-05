#!/bin/bash
~/Onedata/onedata-gui-utils/scripts/copy-gui-to-pod.sh $1 $2
fswatch -o -l 2 --event=Updated ./rel/assets ./rel/assets/scripts/custom-frontpage-integration.js | (while read; do ~/Onedata/onedata-gui-utils/scripts/copy-gui-to-pod.sh $1 $2; done)
