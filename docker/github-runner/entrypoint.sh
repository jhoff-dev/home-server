#!/bin/bash

set -e

cd /home/runner

if [ ! -f .runner ]; then
  ./config.sh \
    --url "${REPOSITORY_URL}" \
    --token "${RUNNER_TOKEN}" \
    --unattended \
    --replace
fi

mkdir -p .ssh
chmod 700 .ssh

cat > .ssh/config <<EOF
Host ssh.jhoff.site
  ProxyCommand /usr/local/bin/cloudflared access ssh --hostname %h --id ${CLOUDFLARE_SSH_TUNNEL_ID} --secret ${CLOUDFLARE_SSH_TUNNEL_TOKEN} 
  IdentityFile ~/.ssh/github-actions
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF

chmod 600 .ssh/config

exec ./run.sh