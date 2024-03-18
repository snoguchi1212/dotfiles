#!/bin/sh

brew install --cask espanso

cat <<-EOF >"${DOTFILES}/espanso/match/password.local.yml"
matches:
  - triggers: [":password:"]
    replace: "{{output}}"
    vars:
      - name: output
        type: shell
        params:
          cmd: "security find-generic-password -a 'password' -w"
EOF

echo "password.local.yml created in espanso/match/ directory!"
