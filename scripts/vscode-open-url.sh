#!/bin/bash

export URL=${1}
export LINES=$(python -c 'import os, re; url = os.environ["URL"]; print re.match(r".*?(\d+(:\d+)?)$", url).group(1)')
export FILE_NAME=$(python -c 'import os; url = os.environ["URL"]; print ":".join(url.split(":")[-3:-2]).split("/")[-1]')
export FILE_URL=$(python -c 'import os; url = os.environ["URL"]; print ":".join(url.split(":")[0:-2])')
export LOCAL_FILE_PATH=/tmp/${FILE_NAME}

wget ${FILE_URL} -O ${LOCAL_FILE_PATH}
open vscode://file/${LOCAL_FILE_PATH}:${LINES}
