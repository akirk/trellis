#!/bin/bash
shopt -s nullglob

show_usage() {
  echo "Usage: vault <command> [<options>...]
Just a proxy of ansible-vault with all files named vault.yml under the group_vars folder.

See 'ansible-vault --help' for more information.

See 'ansible-vault <command> --help' for more information on a specific
command.

Examples:
  vault encrypt
  vault view
  vault decrypt
  vault --help
"
}

[[ $# -lt 1 ]] && { show_usage; exit 127; }

for arg
do
  [[ $arg = -h ]] && { show_usage; exit 0; }
done

VAULT_CMD="find group_vars/ -name vault.yml -exec ansible-vault $1 {} +"

$VAULT_CMD
