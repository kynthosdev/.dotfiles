#!/bin/bash

# Script to install packages via install scripts
# Supports multiple operating systems: Ubuntu/Debian, Fedora/RHEL, Arch, macOS

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt &> /dev/null; then
            echo "ubuntu"
        elif command -v dnf &> /dev/null; then
            echo "fedora"
        elif command -v pacman &> /dev/null; then
            echo "arch"
        else
            echo "linux-other"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# Function to install antibody
install_antibody() {
    if command -v antibody &> /dev/null; then
        print_warning "antibody is already installed, skipping..."
        return 0
    fi

    print_status "Installing antibody..."
    if curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin; then
        print_status "antibody installed successfully"
    else
        print_error "Failed to install antibody"
        return 1
    fi
}

# Function to install pnpm
install_pnpm() {
    if command -v pnpm &> /dev/null; then
        print_warning "pnpm is already installed, skipping..."
        return 0
    fi

    print_status "Installing pnpm..."
    if curl -fsSL https://get.pnpm.io/install.sh | sh -; then
        print_status "pnpm installed successfully"
    else
        print_error "Failed to install pnpm"
        return 1
    fi
}

# Function to install nvm
install_nvm() {
    if [[ -n "$NVM_DIR" ]] && [[ -s "$NVM_DIR/nvm.sh" ]]; then
        print_warning "nvm is already installed, skipping..."
        return 0
    fi

    print_status "Installing nvm..."
    if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash; then
        print_status "nvm installed successfully"
        print_warning "Please restart your shell or run 'source ~/.bashrc' to use nvm"
    else
        print_error "Failed to install nvm"
        return 1
    fi
}

# Function to install Docker
install_docker() {
    local os=$1

    if command -v docker &> /dev/null; then
        print_warning "Docker is already installed, skipping..."
        return 0
    fi

    print_status "Installing Docker..."

    case $os in
        ubuntu)
            print_status "Installing Docker for Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y ca-certificates curl
            sudo install -m 0755 -d /etc/apt/keyrings
            sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
            sudo chmod a+r /etc/apt/keyrings/docker.asc

            # Add the repository to Apt sources:
            sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
            sudo apt update
            sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            ;;

        fedora)
            print_status "Installing Docker for Fedora/RHEL..."
            sudo dnf -y install dnf-plugins-core
            sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
            sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo systemctl start docker
            sudo systemctl enable docker
            ;;

        arch)
            print_status "Installing Docker for Arch Linux..."
            sudo pacman -S --noconfirm docker docker-compose
            sudo systemctl start docker
            sudo systemctl enable docker
            ;;

        macos)
            print_warning "Docker on macOS requires Docker Desktop."
            print_warning "Please download and install Docker Desktop from https://www.docker.com/products/docker-desktop"
            return 0
            ;;

        *)
            print_warning "Docker installation not supported for this OS. Please install manually."
            return 0
            ;;
    esac

    if command -v docker &> /dev/null; then
        print_status "Docker installed successfully"
    else
        print_error "Failed to install Docker"
        return 1
    fi
}

# Main installation function
main() {
    print_status "Starting installation of development tools..."
    local os=$(detect_os)
    print_status "Detected OS: $os"

    local failed_tools=()

    # Install tools (continue even if some fail)
    if ! install_antibody; then
        failed_tools+=("antibody")
    fi

    if ! install_pnpm; then
        failed_tools+=("pnpm")
    fi

    if ! install_nvm; then
        failed_tools+=("nvm")
    fi

    if ! install_docker "$os"; then
        failed_tools+=("docker")
    fi

    # Report results
    if [ ${#failed_tools[@]} -eq 0 ]; then
        print_status "All tools installed successfully!"
    else
        print_warning "Some tools failed to install: ${failed_tools[*]}"
        print_warning "You can try installing them manually or run the script again with proper permissions."
    fi

    print_status "Installation process completed! You may need to restart your shell to use some tools."
}

# Run main function
main "$@"
