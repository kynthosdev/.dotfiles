####  INSTALL PACKAGES  ####
# Install packages and dependencies
sudo pacman --noconfirm -Sy \
	awesome \
	sddm \
	stow \
	bat \
	kitty \
	zsh \
	neovim \
	maim \
        unzip \
	ranger \
	ttf-meslo-nerd-font-powerlevel10k \
	ttf-jetbrains-mono-nerd
	#kwallet-pam \
	#libvirt qemu-full virt-manager x11-ssh-askpass \
        #freecad


# Install packages from AUR

# Install packages via install scripts
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

####  CONFIGURATION DEFAULTS   ####
# Stow all packages and restore after --adopt
echo "Stowing packages ...."
stow --adopt \
	zsh \
	nvim \
	kitty \
	neofetch \
	paru
	#kwallet


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
sudo systemctl enable sddm.service

# Add user to groups
# echo "Add user to groups"
# sudo usermod -aG libvirt $USER

# *keep last* Use zsh as default shell
sudo chsh -s $(which zsh) $USER

# System clean up
echo "Restore git files after stow --adopt"
git restore .
