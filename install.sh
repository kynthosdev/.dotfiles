# SETUP NIX 
# Install Nix package manager
#sh <(curl -L https://nixos.org/nix/install) --daemon

# Source Nix
#if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
#fi

#nix-shell -p nix-info --run "nix-info -m"

# Install packages through Nix
#nix-env -iA \
#	nixpkgs.stow \
#	nixpkgs.bat \
#	nixpkgs.kitty \
#	nixpkgs.zsh \
#	nixpkgs.antibody \
#	nixpkgs.neovim

####  INSTALL PACKAGES  ####
# Update system
sudo pacman -Syu


# Install packages and dependencies
sudo pacman --noconfirm -Sy \
	stow \
	bat \
	kitty \
	zsh \
	neovim \
	maim \
  unzip \
	ranger \
	dolphin \
	kwallet-pam \
	ttf-meslo-nerd \
	ttf-jetbrains-mono-nerd \
	libvirt qemu-full virt-manager x11-ssh-askpass \
  freecad


# Install packages from AUR
paru -S \
	arcolinux_repo_3party/kwin-bismuth \
	plasma5-applets-virtual-desktop-bar-git \
	lightly-git \
	lightlyshaders-git \
	ttf-google-sans  \
  autofs


# Install packages via install scripts
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin



####  CONFIGURATION DEFAULTS   ####
# Stow all packages and restore after --adopt
echo "Stowing packages ...."
stow --adopt \
	zsh \
	kitty \
	kde-base-config \
	dolphin \
	neofetch \
	paru \
	plasma \
	kwallet \
	themes

echo "Restore git files after stow --adopt"
git restore .

# Git global settings
echo "Set git global settings"
git config --global user.email "kynthosdevelopment@gmail.com"
git config --global user.name "kynthosdev"

###   CONFIGURE PACKAGES   ####
##  ZSH  ##
echo " Add zsh to shells"
command -v zsh | sudo tee -a /etc/shells

echo "Bundle zsh plugins"
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Enable services
echo "Enable services"
sudo systemctl enable libvirtd.service

# Add user to groups
echo "Add user to groups"
sudo usermod -aG libvirt $USER

# *keep last* Use zsh as default shell
sudo chsh -s $(which zsh) $USER

# Install program configs
# git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
