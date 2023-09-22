#!/bin/bash

# The configuration file
CONFIG_FILE="$HOME/.config/gh/hosts.yml"

# A function to get the username from the hosts file
get_username() {
    [ -f "$CONFIG_FILE" ] && awk '/user:/ {print $2}' $CONFIG_FILE || echo ""
}

# Function to backup current user
backup_current() {
    if [ -f "$CONFIG_FILE" ]; then
        CURRENT_FILE="$HOME/.config/gh/hosts_$(get_username).yml"
        cp $CONFIG_FILE $CURRENT_FILE
    # else
        # echo "Config file not found, skipping backup."
    fi
}
# Backup file
BACKUP_FILE="$HOME/.config/gh/hosts_$(get_username).yml"

# Backup before start just in case
backup_current

# A function to set the Git global username and email.
set_git_config() {
    local username=$(get_username)
    git config --global user.name "$username"
    git config --global user.email "${username}@users.noreply.github.com"
}

usage() {
    echo "Usage: $0 {auth|swap|list|init}"
    echo "  auth - Backs up the current hosts file, then attempts to log in and set up git. If login fails, restores the hosts file from the backup."
    echo "  swap USERNAME - Replaces the current hosts file with the file named hosts_USERNAME.yml, then attempts to setup git."
    echo "  list - Lists all usernames that have backup files."
    exit 1
}

[ $# -eq 0 ] && usage

# Check for write permissions only if file exists
if [ -f "$CONFIG_FILE" ]; then
    if [ ! -w $CONFIG_FILE ]; then
        echo "Error: No write permissions for $CONFIG_FILE"
        exit 1
    fi
# else
    # echo "Config file not found, skipping write permissions check."
fi

case "$1" in
  auth)
    gh auth login
    if [ $? -eq 0 ]; then
        gh auth setup-git
        gh auth status
        set_git_config
        backup_current
    else
        cp $BACKUP_FILE $CONFIG_FILE
        echo "gh auth login failed, restoring the original file"
    fi
    ;;
  swap)
    if [ -z "$2" ]; then
      echo "Please provide a username. Correct syntax: mgh swap USERNAME"
      exit 1
    fi
    SWAP_FILE="$HOME/.config/gh/hosts_$2.yml"
    if [ -f $SWAP_FILE ]; then
      cp $SWAP_FILE $CONFIG_FILE
      gh auth setup-git
      gh auth status
      set_git_config
    else
      echo "File $SWAP_FILE does not exist."
      exit 1
    fi
    ;;
  list)
    for file in $HOME/.config/gh/hosts_*.yml; do
      basename $file | sed 's/^hosts_\(.*\)\.yml/\1/'
    done
    ;;
  *)
    usage
esac
exit 0
