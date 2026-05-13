#!/bin/bash

filter=$1
if [ "$filter" == "" ]; then
  filter=".*"
fi
gui_name=$(pwd | grep -Eo '[^/]+$')
if [ -z "$(ls | grep src)" ]; then
  app_dir="."
else
  app_dir="src"
fi

case "$gui_name" in
  onepanel-gui)
    worker_name=oz-panel
    ;;
  onezone-gui)
    worker_name=oz-worker
    ;;
  oneprovider-gui)
    worker_name=op-worker
    ;;
  *)
    echo "Not supported GUI: " $gui_name
    exit 0
    ;;
esac

tmux new-session -d -s ${gui_name}
tmux send-keys -t ${gui_name} "cd ${app_dir} && ember build --output-path=../rel --environment=development-backend --watch" C-m
tmux split-window -h
tmux send-keys -t ${gui_name} "~/Onedata/onedata-gui-utils/scripts/watch-copy-gui-to-pod.sh $worker_name ~/Onedata/one-env-focal/src-25.05" C-m
tmux attach -t ${gui_name}
