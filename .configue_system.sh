####  CONFIGURATION DEFAULTS   ####
# Stow all packages and restore after --adopt
echo "Stowing packages ...."
sleep 1
stow --adopt \
	zsh \
	nvim \
 	awesome \
  dolphin \
	kitty \
	neofetch \
  code \
	paru

# Git global settings
echo "Set git global settings ...."
sleep 1
git config --global user.email "kynthosdevelopment@gmail.com"
git config --global user.name "kynthosdev"
git config --global init.defaultBranch "main"

# Development CONFIGURATION
sudo pnpm add -g @quasar/cli hygen

# SSH keygen
echo "Generate ssh key ...."
ssh-keygen -t ed25519


###   CONFIGURE PACKAGES   ####
##  ZSH  ##
echo " Add zsh to shells ...."
command -v zsh | sudo tee -a /etc/shells


echo "Bundle zsh plugins ...."
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh


# Enable services
echo "Enable services"
sudo systemctl enable sddm.service
sudo systemctl enable acpid.service
sudo systemctl enable laptop-mode.service
sudo systemctl enable docker.service


# Add user to groups
echo "Add user to groups ...."
sudo usermod -aG libvirt $USER

# This is specific to devices - find script that mounts based on available devices 
echo "Mount storage device ..."
sleep 1
echo "UUID=d80ce190-f301-4628-a9e3-26c30ca2421f /mnt              ext4    defaults,noatime 0 1" | sudo tee -a /etc/fstab



# *keep last* Use zsh as default shell
sudo chsh -s $(which zsh) $USER

