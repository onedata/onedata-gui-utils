#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FILTER=$1
if [ "$FILTER" == "" ]; then
  FILTER=".*"
fi
GUI_NAME=$(pwd | grep -Eo '[^/]+$')
if [ -z "$(ls | grep src)" ]; then
  APP_DIR="."
else
  APP_DIR="src"
fi

if [ "$BACKEND_SRC_ROOT" == "" ]; then
  BACKEND_SRC_ROOT=~/Onedata/one-env-focal/src-dev
fi

case "$GUI_NAME" in
  onepanel-gui)
    WORKER_NAME=oz-panel
    ;;
  onezone-gui)
    WORKER_NAME=oz-worker
    ;;
  oneprovider-gui)
    WORKER_NAME=op-worker
    ;;
  *)
    echo "Not supported GUI: " $GUI_NAME
    exit 1
    ;;
esac

TMUX_SESSION_NAME=${GUI_NAME}

trap "tmux kill-session -t ${TMUX_SESSION_NAME}" EXIT

tmux new-session -d -s ${TMUX_SESSION_NAME}
tmux send-keys -t ${TMUX_SESSION_NAME} "cd ${APP_DIR} && ember build --output-path=../rel --environment=development-backend --watch" C-m
tmux split-window -h
tmux send-keys -t ${TMUX_SESSION_NAME} "${SCRIPT_DIR}/watch-copy-gui-to-pod.sh ${WORKER_NAME} ${BACKEND_SRC_ROOT}" C-m
tmux attach -t ${TMUX_SESSION_NAME}
