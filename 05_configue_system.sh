####  CONFIGURATION DEFAULTS   ####
# Stow all packages and restore after --adopt
echo "Stowing packages ...."
sleep 2
stow --adopt \
	zsh \
	nvim \
  	dolphin \
	neofetch \
  	code \
	paru

# Git global settings
echo "Set git global settings ...."
sleep 2
git config --global user.email "kynthosdevelopment@gmail.com"
git config --global user.name "kynthosdev"
git config --global init.defaultBranch "main"

# SSH keygen
echo "Generate ssh key ...."
sleep 2
ssh-keygen -t ed25519


###   CONFIGURE PACKAGES   ####
##  ZSH  ##
echo " Add zsh to shells ...."
sleep 2
command -v zsh | sudo tee -a /etc/shells


echo "Bundle zsh plugins ...."
sleep 2
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh


# Enable services
echo "Enable services"
sleep 2
sudo systemctl enable sddm.service
sudo systemctl enable docker.service


# Add user to groups
echo "Add user to groups ...."
sleep 2
sudo usermod -aG libvirt $USER

# This is specific to devices - find script that mounts based on available devices 
echo "Mount storage device ..."
sleep 2
echo "UUID=d80ce190-f301-4628-a9e3-26c30ca2421f /mnt              ext4    defaults,noatime 0 1" | sudo tee -a /etc/fstab

# *keep last* Use zsh as default shell
sudo chsh -s $(which zsh) $USER

