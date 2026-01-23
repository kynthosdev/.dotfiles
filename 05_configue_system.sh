#!/usr/bin/env bash

# System Configuration Script
# This script configures the system with dotfiles, git settings, SSH keys,
# zsh configuration, system services, user groups, and storage mounting.

# Exit immediately if any command fails
set -e

# =============================================
# CONFIGURATION VARIABLES
# =============================================

# Git Configuration
GIT_EMAIL="kynthosdevelopment@gmail.com"
GIT_USERNAME="kynthosdev"
GIT_DEFAULT_BRANCH="main"

# SSH Configuration
SSH_KEY_TYPE="ed25519"

# Zsh Configuration
ZSH_PLUGINS_FILE="$HOME/.zsh_plugins.txt"
ZSH_PLUGINS_OUTPUT="$HOME/.zsh_plugins.sh"

# Storage Configuration
STORAGE_UUID="d80ce190-f301-4628-a9e3-26c30ca2421f"
STORAGE_MOUNT_POINT="/mnt"
STORAGE_FS_TYPE="ext4"
STORAGE_MOUNT_OPTIONS="defaults,noatime"

# Packages to stow
STOW_PACKAGES=(
    "zsh"
    "nvim"
    # "dolphin"
    "neofetch"
    # "code"
    # "paru"
    "allacritty"
    # "optimus-manager"
    # "rclone"
)

# System Services
SYSTEM_SERVICES=(
    # "sddm.service"
    "docker.service"
)

# User Groups
USER_GROUPS=(
    # "libvirt"
    "docker"
    # "gamemode"
)

# =============================================
# MAIN CONFIGURATION FUNCTIONS
# =============================================

function configure_stow_packages {
    echo "Stowing packages ...."
    sleep 2
    stow --adopt "${STOW_PACKAGES[@]}"
}

function configure_git {
    echo "Set git global settings ...."
    sleep 2
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_USERNAME"
    git config --global init.defaultBranch "$GIT_DEFAULT_BRANCH"
}

function configure_ssh {
    echo "Generate ssh key ...."
    sleep 2
    ssh-keygen -t "$SSH_KEY_TYPE"
}

function configure_zsh {
    echo "Add zsh to shells ...."
    sleep 2
    command -v zsh | sudo tee -a /etc/shells

    echo "Bundle zsh plugins ...."
    sleep 2
    antibody bundle < "$ZSH_PLUGINS_FILE" > "$ZSH_PLUGINS_OUTPUT"
}

function configure_services {
    echo "Enable services"
    sleep 2
    for service in "${SYSTEM_SERVICES[@]}"; do
        sudo systemctl enable "$service"
    done
}

function configure_user_groups {
    echo "Add user to groups ...."
    sleep 2
    for group in "${USER_GROUPS[@]}"; do
        sudo usermod -aG "$group" "$USER"
    done
}

function configure_storage {
    echo "Mount storage device ..."
    sleep 2
    echo "UUID=$STORAGE_UUID $STORAGE_MOUNT_POINT $STORAGE_FS_TYPE $STORAGE_MOUNT_OPTIONS 0 1" | sudo tee -a /etc/fstab
}

function set_default_shell {
    echo "Set zsh as default shell"
    sudo chsh -s "$(which zsh)" "$USER"
}

# =============================================
# MAIN EXECUTION
# =============================================

echo "Starting system configuration..."

# Configuration steps
configure_stow_packages
configure_git
configure_ssh
configure_zsh
configure_services
configure_user_groups
configure_storage
set_default_shell

echo "System configuration completed successfully!"