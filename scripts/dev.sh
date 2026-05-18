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
    $SCRIPT_DIR/tmux-onenv.sh
    ;;
  "test")
    $SCRIPT_DIR/tmux-test.sh $ARGS
    ;;
  *)
    echo "Usage:"
    echo "  $0 serve [port=$SERVE_DEFAULT_PORT]"
    echo "  $0 onenv"
    echo "  $0 test [filter]"
    exit 1
    ;;
esac
