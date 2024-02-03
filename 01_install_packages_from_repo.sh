echo Install packages and dependencies from repos........
sleep 3
sudo pacman --noconfirm -Sy \
	pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack \
  plasma-desktop sddm \
  bluedevil plasma-nm plasma-pa kdegraphics-thumbnailers ffmpegthumbs kwallet-pam dolphin \
	picom stow bat zsh neovim maim unzip \
	ttf-meslo-nerd-font-powerlevel10k ttf-roboto ttf-jetbrains-mono-nerd \
	libvirt qemu-full virt-manager x11-ssh-askpass \
  steam \
  nodejs-lts-iron yarn docker docker-compose \
  freecad
