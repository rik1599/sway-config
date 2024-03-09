#
# Packages installs
#
echo "======== Installing packages ========"
sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
	sway \
	sway-backgrounds \
	swayidle \
	swaylock \
	xdg-desktop-portal-wlr \
	xdg-desktop-portal-gtk \
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
	tar \
	libglib2.0-bin \
	network-manager \
	libnotify-bin \

sudo apt install -y --no-install-recommends \
	pavucontrol

#
# Add user to groups
#
echo "======== Adding user to groups ========"
sudo usermod -a -G input,lpadmin $USER

#
# Start services
#
echo "======== Starting services ========"
sudo systemctl enable cups --now
sudo systemctl enable NetworkManager --now

#
# Install configuration files
#
echo "======== Installing configuration files ========"
git clone https://github.com/rik1599/sway-config.git ~/.config
cd ~/.config
git remote set-url origin git@github.com:rik1599/sway-config.git
cd

#
# Neovim
#
echo "======== Installing Neovim ========"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim

#
# Font Awesome 6
#
echo "======== Installing Font Awesome 6 ========"
mkdir -p ~/.local/share/fonts
curl https://use.fontawesome.com/releases/v6.5.1/fontawesome-free-6.5.1-desktop.zip \
	-o fontawesome.zip
unzip -j fontawesome.zip "fontawesome-free-6.5.1-desktop/otfs/*" -d ~/.local/share/fonts
fc-cache
rm fontawesome.zip

#
# Adw-gtk3
#
echo "======== Installing Adw-gtk3 ========"
mkdir -p .local/share/themes
curl -L https://github.com/lassekongo83/adw-gtk3/releases/download/v5.2/adw-gtk3v5-2.tar.xz \
	-o adw-gtk3.tar.xz
tar -xf adw-gtk3.tar.xz -C ~/.local/share/themes
rm adw-gtk3.tar.xz
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

#
# Oh my zsh
#
echo "======== Installing Oh my zsh ========"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "source ~/.config/sway/start" >> .zshrc 

#
# Change shell to zsh
#
echo "======== Changing shell to zsh ========"
chsh $USER -s /usr/bin/zsh

#
# Reboot
#
sudo reboot
