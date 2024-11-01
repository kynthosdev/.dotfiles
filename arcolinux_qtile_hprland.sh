#!/bin/bash
#set -e
###############################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxb.com
# Website	:	https://www.arcolinuxiso.com
# Website	:	https://www.arcolinuxforum.com
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
###############################################################################


###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

func_install_paru() {
	if paru -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	paru -S --noconfirm --needed $1
    fi
}

func_stow() {
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Stowing configuration "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	stow --adopt $1
}

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
# Display manager
sddm

# Desktop
hyprutils
hyprland

#Build utilities
cmake
cpio
meson

# Audio
pipewire-audio 
pipewire-alsa 
pipewire-pulse 
pipewire-jack

#Bluetooth
bluez
bluez-utils
blueman

# Nvidia driver support for Wayland and Steam
nvidia-dkms
nvidia-utils
lib32-nvidia-utils
egl-wayland
libva-nvidia-driver

# Browser
# brave-bin under paru_list

# Core
kitty
alacritty
stow
bat
zsh
neovim
unzip
scrot
dunst
wl-clipboard
polkit
polkit-kde-agent
steam
mpv
xdg-desktop-portal-gtk
docker
docker-compose

# Virtualization
libvirt 
qemu-full 
virt-manager 

# Fonts
ttf-meslo-nerd-font-powerlevel10k 
ttf-roboto 
ttf-jetbrains-mono-nerd
ttf-liberation

# Speciality apps
freecad
)

paru_list=(
visual-studio-code-bin
zsh-antidote
figma-linux
brave-bin
)

stow_list=(
zsh
nvim
neofetch
kitty
qtile
code
alacritty
)

#################################################################################
count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

count=0

for name in "${paru_list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install_paru $name
done

count=0

for name in "${stow_list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Stowing package nr.  "$count " " $name;tput sgr0;
	func_stow $name
done
###############################################################################

tput setaf 5;echo "################################################################"
echo "Installing packages from scripts"
echo "################################################################"
echo;tput sgr0
sleep 2
curl -fsSL https://get.pnpm.io/install.sh | sh -
curl -sSL https://install.python-poetry.org | python3 -
curl -fsSL https://ollama.com/install.sh | sh
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

##############################################################################

tput setaf 5;echo "################################################################"
echo "Restore git files after stow --adopt"
echo "################################################################"
echo;tput sgr0
sleep 2
git restore .

tput setaf 5;echo "################################################################"
echo "Enabling sddm as display manager"
echo "################################################################"
echo;tput sgr0
sleep 2
sudo systemctl enable sddm.service -f

tput setaf 5;echo "################################################################"
echo "Enabling virtualization"
echo "################################################################"
echo;tput sgr0
sleep 2
sudo systemctl enable libvirtd.service -f

tput setaf 5;echo "################################################################"
echo "Enabling bluetooth"
echo "################################################################"
echo;tput sgr0
sleep 2
sudo systemctl enable bluetooth.service -f

tput setaf 5;echo "################################################################"
echo "Enabling docker"
echo "################################################################"
echo;tput sgr0
sleep 2
sudo systemctl enable docker.service -f

tput setaf 5;echo "################################################################"
echo "Setting up git global variables and ssh key"
echo "################################################################"
echo;tput sgr0
sleep 2
git config --global user.email "kynthosdevelopment@gmail.com"
git config --global user.name "kynthosdev"
git config --global init.defaultBranch "main"
ssh-keygen -t ed25519

tput setaf 5;echo "################################################################"
echo "Bundle zsh plugins"
echo "################################################################"
echo;tput sgr0
sleep 2
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

tput setaf 5;echo "################################################################"
echo "Setting up user groups"
echo "################################################################"
echo;tput sgr0
sleep 2
sudo usermod -aG libvirt $USER

tput setaf 5;echo "################################################################"
echo "Setting up mounts"
echo "################################################################"
echo;tput sgr0
sleep 2
echo "UUID=d80ce190-f301-4628-a9e3-26c30ca2421f /mnt              ext4    defaults,noatime 0 1" | sudo tee -a /etc/fstab

tput setaf 5;echo "################################################################"
echo "Setting up zsh"
echo "################################################################"
echo;tput sgr0
sleep 2
command -v zsh | sudo tee -a /etc/shells
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Keep this last in this file
sudo chsh -s $(which zsh) $USER

tput setaf 7;echo "################################################################"
echo "You now have a very minimal functional desktop"
echo "################################################################"
echo;tput sgr0

tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
