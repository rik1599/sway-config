#
# Packages installs
#
echo "Installing packages"
sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
	sway \
	sway-backgrounds \
	swayidle \
	swaylock \
	xdg-desktop-portal-wlr \
	wlsunset \
	xwayland \
	chromium \
	imv \
	flatpak \
	cups \
	simple-scan \
	brightnessctl \
	waybar \
	tofi \
	man-db \
	clipman \
	wl-clipboard \
	grim \
	slurp \
	zsh \
	thunar \
	polkit-kde-agent-1 \
	mako-notifier \
	wlogout \
	wob \
	git \
	bc \
	unzip \
	tar

sudo apt install -y --no-install-recommends \
	pavucontrol

#
# Add user to groups
#
echo "Add user to groups"
sudo usermod -a -G input, lpadmin $USER

#
# Start services
#
echo "Start services"
sudo systemctl enable cups --now

#
# Install configuration files
#
echo "Config files"
git clone https://github.com/rik1599/sway-config.git ~/.config

#
# Neovim
#
echo "Neovim install"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim

#
# Font Awesome 6
#
echo "Font Awesome install"
mkdir -p ~/.local/share/fonts
curl https://use.fontawesome.com/releases/v6.5.1/fontawesome-free-6.5.1-desktop.zip \
	-o fontawesome.zip
unzip -j fontawesome.zip "fontawesome-free-6.5.1-desktop/otfs/*" -d ~/.local/share/fonts
fc-cache
rm fontawesome.zip

#
# Adw-gtk3
#
echo "Adw-gtk3 install"
mkdir -p .local/share/themes
curl -L https://github.com/lassekongo83/adw-gtk3/releases/download/v5.2/adw-gtk3v5-2.tar.xz \
	-o adw-gtk3.tar.xz
tar -xf adw-gtk3.tar.xz -C ~/.local/share/themes
rm adw-gtk3.tar.xz

#
# Flathub setup
#
echo "Flathub setup"
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#
# Oh my zsh
#
echo "Install Oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "source ~/.config/sway/start" >> .zshrc 

#
# Change shell to zsh
#
echo "Changing shell"
chsh $USER -s /usr/bin/zsh

#
# Reboot
#
sudo reboot
