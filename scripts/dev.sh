#!/bin/bash
set -e

# Copyright (C) 2026 Onedata (onedata.org)
# This software is released under the MIT license cited in 'LICENSE.txt'
# Author: Jakub Liput
#
# Convinient command center for launching most commonly used developer operations:
# - serve - starting the development server (ember s),
# - onenv - live build and synchronizing static files with one-env deployment (side-by-side tmux terminal),
# - test - running live build and tests (side-by-side tmux terminal).

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DEV_SCRIPTS_DIR=$SCRIPT_DIR/dev
if [ -z "$(ls | grep src)" ]; then
  APP_DIR="."
else
  APP_DIR="src"
fi

COMMAND="$1"
ARGS="${@:2}"

SERVE_DEFAULT_PORT=4200

case "$COMMAND" in
  "serve")
    if [ -z "$ARGS" ]; then
      ARGS=$SERVE_DEFAULT_PORT
    fi
    cd "$APP_DIR"
    ember s --port=${ARGS}
    ;;
  "onenv")
    $DEV_SCRIPTS_DIR/tmux-onenv.sh
    ;;
  "test")
    $DEV_SCRIPTS_DIR/tmux-test.sh $ARGS
    ;;
  *)
    echo "Usage:"
    echo "  $0 serve [port=$SERVE_DEFAULT_PORT]"
    echo "  $0 onenv [backend-src-root-path]"
    echo "  $0 test [filter]"
    exit 1
    ;;
esac
