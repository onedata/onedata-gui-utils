#!/bin/bash
# This script should be invoked from source dir, eg. "src", where is the Ember's project
# root with fetched dependencies (node_modules).

# Ember addon projects have the Ember project root at the same
# level as the repository root itself. In the other hand main Ember projects
# have the project root nested inside "src" directory. Hence we have to search for
# possible location of ".gitignore" file in two possible levels of nesting.
GITIGNORE_PATH=.gitignore
if [ ! -f "$GITIGNORE_PATH" ]; then
  GITIGNORE_PATH="../$GITIGNORE_PATH"
fi

./node_modules/eslint/bin/eslint.js $@ --ignore-path "$GITIGNORE_PATH" .
