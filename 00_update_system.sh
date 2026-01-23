#!/bin/bash

# Enhanced System Update Script with Multi-Distribution Support
# Supports: Arch Linux, Ubuntu/Debian
# Best practices: error handling, user feedback, logging

# Set strict mode for better error handling
set -euo pipefail

# Global variables
LOG_FILE="/var/log/system_update.log"
DRY_RUN=false
VERBOSE=false

# Function to display help/usage information
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo "  -n, --dry-run   Show what would be done without actually running updates"
    echo "  -v, --verbose   Enable verbose output"
    echo "  --no-log        Disable logging to file"
    echo
    echo "This script updates the system based on the detected Linux distribution."
    echo "Supported distributions: Arch Linux, Ubuntu/Debian"
}

# Function to log messages
log_message() {
    local message="$1"
    local level="${2:-INFO}"

    if [ "$LOG_FILE" != "/dev/null" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" | sudo tee -a "$LOG_FILE" >/dev/null
    fi

    if [ "$VERBOSE" = true ]; then
        echo "[$level] $message"
    fi
}

# Function to check if running as root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        log_message "This script requires root privileges. Please run with sudo." "ERROR"
        exit 1
    fi
}

# Function to detect Linux distribution
detect_distribution() {
    if [ -f /etc/os-release ]; then
        # shellcheck source=/dev/null
        source /etc/os-release
        case "$ID" in
            arch|archarm|manjaro)
                echo "arch"
                ;;
            ubuntu|debian|pop)
                echo "ubuntu"
                ;;
            *)
                log_message "Unsupported distribution: $ID" "ERROR"
                exit 1
                ;;
        esac
    else
        log_message "Cannot detect Linux distribution. /etc/os-release not found." "ERROR"
        exit 1
    fi
}

# Function to update Arch Linux system
update_arch_system() {
    log_message "Starting Arch Linux system update"

    echo "Updating Arch Linux system..."
    echo "1/3: Updating archlinux-keyring..."
    if [ "$DRY_RUN" = true ]; then
        log_message "DRY RUN: Would execute: sudo pacman --noconfirm -Sy archlinux-keyring"
        echo "DRY RUN: Would update archlinux-keyring"
    else
        if sudo pacman --noconfirm -Sy archlinux-keyring; then
            log_message "Successfully updated archlinux-keyring"
        else
            log_message "Failed to update archlinux-keyring" "ERROR"
            exit 1
        fi
    fi

    echo "2/3: Running full system upgrade..."
    if [ "$DRY_RUN" = true ]; then
        log_message "DRY RUN: Would execute: sudo pacman --noconfirm -Syu"
        echo "DRY RUN: Would perform full system upgrade"
    else
        if sudo pacman --noconfirm -Syu; then
            log_message "Successfully completed system upgrade"
        else
            log_message "Failed to complete system upgrade" "ERROR"
            exit 1
        fi
    fi

    echo "3/3: Cleaning package cache..."
    if [ "$DRY_RUN" = true ]; then
        log_message "DRY RUN: Would execute: sudo pacman --noconfirm -Scc"
        echo "DRY RUN: Would clean package cache"
    else
        if sudo pacman --noconfirm -Scc; then
            log_message "Successfully cleaned package cache"
        else
            log_message "Failed to clean package cache" "WARNING"
        fi
    fi

    log_message "Arch Linux system update completed successfully"
    echo "Arch Linux system update completed successfully!"
}

# Function to update Ubuntu/Debian system
update_ubuntu_system() {
    log_message "Starting Ubuntu/Debian system update"

    echo "Updating Ubuntu/Debian system..."
    echo "1/4: Updating package lists..."
    if [ "$DRY_RUN" = true ]; then
        log_message "DRY RUN: Would execute: sudo apt update"
        echo "DRY RUN: Would update package lists"
    else
        if sudo apt update; then
            log_message "Successfully updated package lists"
        else
            log_message "Failed to update package lists" "ERROR"
            exit 1
        fi
    fi

    echo "2/4: Upgrading installed packages..."
    if [ "$DRY_RUN" = true ]; then
        log_message "DRY RUN: Would execute: sudo apt upgrade -y"
        echo "DRY RUN: Would upgrade installed packages"
    else
        if sudo apt upgrade -y; then
            log_message "Successfully upgraded installed packages"
        else
            log_message "Failed to upgrade installed packages" "ERROR"
            exit 1
        fi
    fi

    echo "3/4: Performing distribution upgrade..."
    if [ "$DRY_RUN" = true ]; then
        log_message "DRY RUN: Would execute: sudo apt dist-upgrade -y"
        echo "DRY RUN: Would perform distribution upgrade"
    else
        if sudo apt dist-upgrade -y; then
            log_message "Successfully performed distribution upgrade"
        else
            log_message "Failed to perform distribution upgrade" "ERROR"
            exit 1
        fi
    fi

    echo "4/4: Cleaning up unnecessary packages..."
    if [ "$DRY_RUN" = true ]; then
        log_message "DRY RUN: Would execute: sudo apt autoremove -y"
        echo "DRY RUN: Would clean up unnecessary packages"
    else
        if sudo apt autoremove -y; then
            log_message "Successfully cleaned up unnecessary packages"
        else
            log_message "Failed to clean up unnecessary packages" "WARNING"
        fi
    fi

    log_message "Ubuntu/Debian system update completed successfully"
    echo "Ubuntu/Debian system update completed successfully!"
}

# Function to validate system before updates
validate_system() {
    log_message "Validating system before updates"

    # Check disk space
    local disk_space=$(df -h / | awk 'NR==2 {print $4}')
    if [ "$disk_space" = "" ]; then
        log_message "Cannot determine available disk space" "WARNING"
    else
        log_message "Available disk space: $disk_space"
    fi

    # Check internet connectivity
    if ! ping -c 1 google.com >/dev/null 2>&1; then
        log_message "No internet connectivity detected" "ERROR"
        exit 1
    fi

    log_message "System validation completed"
}

# Main function
main() {
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -n|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            --no-log)
                LOG_FILE="/dev/null"
                shift
                ;;
            *)
                echo "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done

    # Initialize logging
    if [ "$LOG_FILE" != "/dev/null" ]; then
        echo "System Update Log - $(date)" | sudo tee "$LOG_FILE" >/dev/null
    fi

    log_message "Starting system update process"
    echo "Starting system update process..."

    # Validate system
    validate_system

    # Detect distribution
    local distro=$(detect_distribution)
    log_message "Detected distribution: $distro"

    # Check for root privileges
    check_root

    # Run appropriate update function based on distribution
    case "$distro" in
        arch)
            update_arch_system
            ;;
        ubuntu)
            update_ubuntu_system
            ;;
        *)
            log_message "Unsupported distribution detected: $distro" "ERROR"
            exit 1
            ;;
    esac

    log_message "System update process completed successfully"
    echo "System update process completed successfully!"
}

# Run main function
main "$@"