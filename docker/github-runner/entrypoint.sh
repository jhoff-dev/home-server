#!/bin/bash

set -e

cd /home/runner

# Creates the runner configuration file
if [ ! -f .runner ]; then
  ./config.sh \
    --url "${REPOSITORY_URL}" \
    --token "${RUNNER_TOKEN}" \
    --unattended \
    --replace
fi

# Create the .ssh folder in the runner
mkdir -p .ssh
chmod 700 .ssh

# Creates the SSH configuration file to allow connecting via Cloudflare's SSH tunnel
cat > .ssh/config <<EOF
Host ssh.jhoff.site
  ProxyCommand /usr/local/bin/cloudflared access ssh --hostname %h --id ${CLOUDFLARE_SSH_TUNNEL_ID} --secret ${CLOUDFLARE_SSH_TUNNEL_TOKEN} 
  IdentityFile ~/.ssh/github-actions
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF
chmod 600 .ssh/config

# Note: In this folder you also need to have the SSH private key to connect to the server

exec ./run.sh