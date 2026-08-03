#!/bin/bash
set -e

setup_github_ssh() {
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh

  if [ ! -f ~/.ssh/config ]; then
    cat >~/.ssh/config <<'EOF'
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github
  IdentitiesOnly yes
EOF
    chmod 600 ~/.ssh/config
    echo "Created ~/.ssh/config with github.com entry"
  else
    echo "~/.ssh/config already exists, skipping"
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  setup_github_ssh
fi
