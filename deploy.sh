#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <username> <host> <directory>"
  exit 1
fi

USERNAME="$1"
HOST="$2"
DIRECTORY="$3"

set -xe

ssh "$USERNAME@$HOST" "mkdir -p .deploy/ && cd .deploy && rm -rf '$DIRECTORY'" && \
  scp -r "$DIRECTORY" "$USERNAME@$HOST:.deploy/" && \
  ssh -f "$USERNAME@$HOST" "cd '.deploy/$DIRECTORY' && nohup ./run.sh < /dev/null > nohup.out 2>&1 &"
