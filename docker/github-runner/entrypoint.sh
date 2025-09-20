#!/bin/bash

set -e

cd /home/runner

REPO=${REPOSITORY_NAME}
OWNER_REPO=jhoff-dev

# Generate token of runner
RUNNER_TOKEN=$(curl -s -X POST \
    -H "Authorization: token ${GITHUB_PAT}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${OWNER_REPO}/${REPO}/actions/runners/registration-token" \
    | jq -r '.token')

# Runner settings
if [ ! -f .runner ]; then
  ./config.sh \
    --url "https://github.com/${OWNER_REPO}/${REPO}" \
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
cat > github-actions <<EOF
${RSYNC_RUNNER_PRIVATE_KEY}
EOF
chmod 600 .ssh/github-actions

exec ./run.sh