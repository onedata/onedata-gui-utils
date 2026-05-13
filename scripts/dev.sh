#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -z "$(ls | grep src)" ]; then
  APP_DIR="."
else
  APP_DIR="src"
fi

COMMAND="$1"
ARGS="${@:2}"

case "$COMMAND" in
  "serve")
    if [ -z "$ARGS" ]; then
      ARGS=4200
    fi
    cd "$APP_DIR"
    ember s --port=${ARGS}
    ;;
  "onenv")
    $SCRIPT_DIR/tmux-onenv.sh
    ;;
  "test")
    $SCRIPT_DIR/tmux-test.sh
    ;;
  *)
    echo "Usage: $0 {serve [port]}"
    exit 1
    ;;
esac
