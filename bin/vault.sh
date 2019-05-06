#!/bin/bash
shopt -s nullglob

show_usage() {
  echo "Usage: vault <mode>

<mode> can be ("encrypt", "decrypt")

Examples:
  vault encrypt
  vault decrypt
"
}

[[ $# -lt 1 ]] && { show_usage; exit 127; }

for arg
do
  [[ $arg = -h ]] && { show_usage; exit 0; }
done

MODE="$1"; shift

if [[ $MODE -ne "encrypt" && $MODE -ne "encrypt" ]]; then
  echo "Error: $MODE is not a valid vault command."
  show_usage;
  exit 127;
fi

FILES=$@;

[[ $# -lt 1 ]] && { FILES="group_vars/all/vault.yml group_vars/development/vault.yml group_vars/staging/vault.yml"; }

VAULT_CMD="ansible-vault $MODE $FILES"

$VAULT_CMD
