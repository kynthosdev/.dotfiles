#####  INSTALL PACKAGES  ####
echo Updating system........
sleep 1
sudo pacman --noconfirm -Sy archlinux-keyring
sudo pacman --noconfirm -Syu

echo Install packages and dependencies........
sleep 1
sudo pacman --noconfirm -Sy \
	awesome \
	sddm \
	pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack \
  conky xfce4-power-manager \
	stow \
	bat \
	kitty \
	zsh \
	neovim \
	maim \
 	unzip \
	ranger \
	ttf-meslo-nerd-font-powerlevel10k ttf-roboto ttf-jetbrains-mono-nerd \
 	rofi \
 	picom \
	libvirt qemu-full virt-manager x11-ssh-askpass \
  steam \
  acpid \
  nodejs docker docker-compose \
  freecad


echo Install packages from AUR........
sleep 1
paru -Sy --noconfirm \
  google-chrome \
  laptop-mode-tools \
  degit \
  visual-studio-code-bin

echo Install packages via install scripts........
sleep 1
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
curl -fsSL https://get.pnpm.io/install.sh | sh -
