#####  INSTALL PACKAGES  ####
echo Updating system........
sleep 1
sudo pacman --noconfirm -Syu
sudo pacman --noconfirm -Sy archlinux-keyring

echo Install packages and dependencies........
sleep 1
sudo pacman --noconfirm -Sy \
	awesome \
	sddm \
	pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack \
	stow \
	bat \
	kitty \
	zsh \
	neovim \
	maim \
  	unzip \
	ranger \
	dolphin qt5ct \
	ttf-meslo-nerd-font-powerlevel10k ttf-roboto ttf-jetbrains-mono-nerd \
 	rofi \
 	picom \
 	lxappearance \
 	papirus-icon-theme \
 	capitaine-cursors
	libvirt qemu-full virt-manager x11-ssh-askpass \
  freecad


echo Install packages from AUR........
sleep 1
paru -Sy --noconfirm \
  google-chrome

echo Install packages via install scripts........
sleep 1
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
