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
echo "Stow list"
###############################################################################

stow_list=(
zsh
nvim
neofetch
kitty
)

count=0

for name in "${stow_list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Stowing package nr.  "$count " " $name;tput sgr0;
	func_stow $name
done


###############################################################################

tput setaf 5;echo "################################################################"
echo "Restore git files after stow --adopt"
echo "################################################################"
echo;tput sgr0
sleep 2
git restore .

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

tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
