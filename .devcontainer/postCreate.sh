#!/bin/bash
set -e

python --version && echo 'Python is ready!'

# Ensure zip is available for the "Download my work" helper
if ! command -v zip >/dev/null 2>&1; then
  sudo apt-get update && sudo apt-get install -y zip
fi

# Custom terminal prompt (only added once — guard prevents duplicates on rebuild)
if ! grep -q '# bp-custom-prompt' ~/.bashrc; then
cat >> ~/.bashrc << 'BASHRC'

# bp-custom-prompt: coloured prompt + reset output colour
# PS1 ends with yellow so typed commands appear yellow; preexec resets before output
PS1="\[\e[1;35m\]❯ \[\e[1;36m\]\w\[\e[0;33m\]\$(git branch 2>/dev/null | grep '\*' | cut -d' ' -f2 | xargs -I{} echo ' ({})')\[\e[0m\]\n\[\e[1;32m\]\$ \[\e[1;33m\]"

if declare -f preexec >/dev/null 2>&1; then
    eval "$(declare -f preexec | sed '1s/preexec/_preexec_orig/')"
    preexec() { printf "\e[0m"; _preexec_orig "$@"; }
else
    trap 'printf "\e[0m"' DEBUG
fi
BASHRC
fi
