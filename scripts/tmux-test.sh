#!/bin/bash

filter=$1
if [ "$filter" == "" ]; then
  filter=".*"
fi
test_name=$(pwd | grep -Eo '[^/]+$')
test_dir=~/Onedata/tmp/ember-test-${test_name}
if [ -z "$(ls | grep src)" ]; then
  app_dir="."
else
  app_dir="src"
fi

tmux new-session -d -s dev
tmux send-keys -t dev "cd ${app_dir} && ember build --output-path=${test_dir} --environment=test --watch" C-m
tmux split-window -h
tmux send-keys -t dev "cd ${app_dir} && sleep 40 && ember t --server --test-port 0 --launch=Chromium --path=${test_dir} --filter='${filter}'" C-m
tmux attach -t dev
