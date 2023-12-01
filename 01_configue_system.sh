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
	paru


# Git global settings
echo "Set git global settings ...."
sleep 1
git config --global user.email "kynthosdevelopment@gmail.com"
git config --global user.name "kynthosdev"


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


# Add user to groups
echo "Add user to groups ...."
sudo usermod -aG libvirt $USER


# *keep last* Use zsh as default shell
sudo chsh -s $(which zsh) $USER

