#!/bin/bash
# This script should be invoked from source dir, eg. "src", where is the Ember's project
# root with fetched dependencies (node_modules).
./node_modules/eslint/bin/eslint.js --fix `git ls-files | grep '.*.js$'`
