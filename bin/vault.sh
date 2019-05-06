#!/bin/bash
shopt -s nullglob

DEFAULT_FILES="group_vars/all/vault.yml group_vars/development/vault.yml group_vars/staging/vault.yml";

show_usage() {
  echo "Usage: vault <command> [<options>...]
Just a proxy of ansible-vault with default files:
$DEFAULT_FILES

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

COMMAND="$1"; shift
FILES=$@;

[[ $# -lt 1 ]] && { FILES="$DEFAULT_FILES"; }

VAULT_CMD="ansible-vault $COMMAND $FILES"

$VAULT_CMD
