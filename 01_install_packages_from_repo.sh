#!/bin/bash

# Enhanced Package Installation Script with Multi-Distribution Support
# Supports: Arch Linux, Ubuntu/Debian
# Features: Individual package installation, error handling, detailed reporting

# Set strict mode for better error handling
set -euo pipefail

# Global variables
LOG_FILE="/var/log/package_installation.log"
DRY_RUN=false
VERBOSE=false
PACKAGE_LIST=()

# Function to define package list
define_packages() {
    # Package list - organized by category for easy maintenance
    PACKAGE_LIST=(
        # Audio and Multimedia
        # pipewire-audio
        # pipewire-alsa
        # pipewire-pulse
        # pipewire-jack

        # Desktop Environment (KDE Plasma)
        # plasma-desktop
        # sddm
        neofetch
        # rclone

        # KDE Utilities
        # bluedevil
        # plasma-nm
        # plasma-pa
        # kdegraphics-thumbnailers
        # ffmpegthumbs
        # kwallet-pam
        # dolphin
        # trash-cli
        # xclip

        # System Utilities
        picom
        stow
        bat
        zsh
        neovim
        unzip
        flameshot

        # Fonts
        ttf-meslo-nerd-font-powerlevel10k
        ttf-roboto
        ttf-jetbrains-mono-nerd

        # Virtualization
        libvirt
        qemu-full
        virt-manager
        x11-ssh-askpass

        # Gaming
        # steam
        # gamemode
        # lib32-gamemode

        # Development Tools
        nodejs-lts-iron
        yarn
        docker
        docker-compose

        # Productivity
        freecad
        # obsidian
    )

    log_message "Defined ${#PACKAGE_LIST[@]} packages for installation"
}

# Function to display help/usage information
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo "  -n, --dry-run   Show what would be done without actually installing packages"
    echo "  -v, --verbose   Enable verbose output"
    echo "  --no-log        Disable logging to file"
    echo
    echo "This script installs packages from repositories with robust error handling."
    echo "Failed packages are skipped and reported at the end."
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

# Function to install packages on Arch Linux
install_arch_packages() {
    local success_count=0
    local fail_count=0
    local failed_packages=()
    local start_time=$(date +%s)

    log_message "Starting Arch Linux package installation"

    # First update package database
    echo "Updating package database..."
    if [ "$DRY_RUN" = true ]; then
        log_message "DRY RUN: Would execute: sudo pacman --noconfirm -Sy"
        echo "DRY RUN: Would update package database"
    else
        if sudo pacman --noconfirm -Sy; then
            log_message "Successfully updated package database"
        else
            log_message "Failed to update package database" "ERROR"
            exit 1
        fi
    fi

    # Install packages individually
    echo "Installing ${#PACKAGE_LIST[@]} packages..."
    echo "----------------------------------------"

    for package in "${PACKAGE_LIST[@]}"; do
        echo "Installing $package..."

        if [ "$DRY_RUN" = true ]; then
            log_message "DRY RUN: Would install package: $package"
            echo "DRY RUN: Would install $package"
            ((success_count++))
        else
            if sudo pacman --noconfirm -S "$package"; then
                log_message "Successfully installed: $package"
                echo "✓ Successfully installed $package"
                ((success_count++))
            else
                log_message "Failed to install: $package" "WARNING"
                echo "✗ Failed to install $package (skipping)"
                failed_packages+=("$package")
                ((fail_count++))
            fi
        fi
    done

    # Generate installation report
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))

    echo "----------------------------------------"
    echo "Installation Summary:"
    echo "  Total packages: ${#PACKAGE_LIST[@]}"
    echo "  Successfully installed: $success_count"
    echo "  Failed/skipped: $fail_count"
    echo "  Time taken: ${duration} seconds"

    if [ "$fail_count" -gt 0 ]; then
        echo "  Failed packages:"
        for pkg in "${failed_packages[@]}"; do
            echo "    - $pkg"
        done
        log_message "Completed with $fail_count failed packages: ${failed_packages[*]}" "WARNING"
    else
        echo "  All packages installed successfully!"
        log_message "All packages installed successfully"
    fi

    echo "----------------------------------------"
    echo "Google Drive via rclone: https://rclone.org/drive/"
}

# Function to install packages on Ubuntu/Debian
install_ubuntu_packages() {
    local success_count=0
    local fail_count=0
    local failed_packages=()
    local start_time=$(date +%s)

    log_message "Starting Ubuntu/Debian package installation"

    # First update package lists
    echo "Updating package lists..."
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

    # Install packages individually
    echo "Installing ${#PACKAGE_LIST[@]} packages..."
    echo "----------------------------------------"

    for package in "${PACKAGE_LIST[@]}"; do
        echo "Installing $package..."

        if [ "$DRY_RUN" = true ]; then
            log_message "DRY RUN: Would install package: $package"
            echo "DRY RUN: Would install $package"
            ((success_count++))
        else
            if sudo apt install -y "$package"; then
                log_message "Successfully installed: $package"
                echo "✓ Successfully installed $package"
                ((success_count++))
            else
                log_message "Failed to install: $package" "WARNING"
                echo "✗ Failed to install $package (skipping)"
                failed_packages+=("$package")
                ((fail_count++))
            fi
        fi
    done

    # Generate installation report
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))

    echo "----------------------------------------"
    echo "Installation Summary:"
    echo "  Total packages: ${#PACKAGE_LIST[@]}"
    echo "  Successfully installed: $success_count"
    echo "  Failed/skipped: $fail_count"
    echo "  Time taken: ${duration} seconds"

    if [ "$fail_count" -gt 0 ]; then
        echo "  Failed packages:"
        for pkg in "${failed_packages[@]}"; do
            echo "    - $pkg"
        done
        log_message "Completed with $fail_count failed packages: ${failed_packages[*]}" "WARNING"
    else
        echo "  All packages installed successfully!"
        log_message "All packages installed successfully"
    fi

    echo "----------------------------------------"
    echo "Google Drive via rclone: https://rclone.org/drive/"
}

# Function to validate system before installation
validate_system() {
    log_message "Validating system before package installation"

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
        echo "Package Installation Log - $(date)" | sudo tee "$LOG_FILE" >/dev/null
    fi

    log_message "Starting package installation process"
    echo "Install packages and dependencies from repos........"

    # Small delay for user to read
    sleep 2

    # Validate system
    validate_system

    # Define package list
    define_packages

    # Detect distribution
    local distro=$(detect_distribution)
    log_message "Detected distribution: $distro"

    # Check for root privileges
    check_root

    # Run appropriate installation function based on distribution
    case "$distro" in
        arch)
            install_arch_packages
            ;;
        ubuntu)
            install_ubuntu_packages
            ;;
        *)
            log_message "Unsupported distribution detected: $distro" "ERROR"
            exit 1
            ;;
    esac

    log_message "Package installation process completed"
    echo "Package installation process completed!"
}

# Run main function
main "$@"