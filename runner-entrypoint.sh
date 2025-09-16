#!/bin/bash

set -e

cd /home/runner

if [ ! -f .runner ]; then
  ./config.sh \
    --url "${GITHUB_URL}" \
    --token "${RUNNER_TOKEN}" \
    --unattended \
    --replace
fi

exec ./run.sh