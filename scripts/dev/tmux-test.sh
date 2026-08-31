#!/bin/bash

# Copyright (C) 2026 Onedata (onedata.org)
# This software is released under the MIT license cited in 'LICENSE.txt'
# Author: Jakub Liput

FILTER=$@
if [ "$FILTER" == "" ]; then
  FILTER=".*"
fi
GUI_NAME=$(pwd | grep -Eo '[^/]+$')
TEST_DIR=/tmp/ember-test-${GUI_NAME}
if [ -z "$(ls | grep src)" ]; then
  APP_DIR="."
else
  APP_DIR="src"
fi
TMUX_SESSION_NAME=${GUI_NAME}-${RANDOM}

trap "tmux kill-session -t ${TMUX_SESSION_NAME}" EXIT

tmux new-session -d -s ${TMUX_SESSION_NAME}
tmux send-keys -t ${TMUX_SESSION_NAME} "cd ${APP_DIR} && ember build --output-path=${TEST_DIR} --environment=test --watch" C-m
tmux split-window -h
tmux send-keys -t ${TMUX_SESSION_NAME} "cd ${APP_DIR} && sleep 40 && ember t --server --test-port 0 --launch=Chromium --path=${TEST_DIR} --filter='${FILTER}'" C-m
tmux attach -t ${TMUX_SESSION_NAME}
