#!/bin/bash

chmod +x *.sh

apt install -y ufw
/sbin/ufw default deny incoming
/sbin/ufw default allow outgoing
systemctl enable ufw
echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/44noextrapackages
echo 'APT::Install-Suggests "false";' > /etc/apt/apt.conf.d/44noextrapackages
echo "Disable apt recommends and suggests (/etc/apt/apt.conf.d/44noextrapackages)"

apt install -y gnome-core gnome-shell gdm3 tmux sudo tree git gnome-terminal nautilus
# (needs complete logout and re-login to be effective)
/sbin/usermod -aG sudo user
systemctl enable gdm3

read -p "Reboot? y/n" answer
if [ $answer == "y" ]; then
  /sbin/reboot
fi

sudo apt install -y \
  chrome-gnome-shell \
  curl \
  deja-dup \
  diff3 \
  feud \
  ffmpeg \
  ghostscript \
  gnome-backgrounds \
  gnome-bluetooth-send \
  gnome-calculator \
  gnome-calculator \
  gnome-clocks \
  gnome-clocks \
  gnome-color-manager \
  gnome-control-center \
  gnome-disk-utility \
  gnome-font-viewer \
  gnome-initial-setup \
  gnome-keyring-pacs11 \
  gnome-remote-desktop \
  gnome-settings-daemon \
  gnome-shell-extension-manager \
  gnome-software-common \
  gnome-system-monitor \
  gnome-tweaks \
  gnome-weather \
  jq \
  keepassxc \
  nautilus-extension-gnome-terminal \
  network-manager \
  network-manager-gnome \
  nfts-3g \
  p7zip-full \
  refetch \
  sed \
  software-properties-common \
  systemsettings \
  task-desktop \
  unzip \
  vim \
  vlc \
  wget \
  xdg-utils \
  zsh

sudo apt install -y tlp tlp-rdw porto

sudo systemctl enable tlp
sudo systemctl start tlp

sudo sed -i 's/main/main contrib non-free/' /etc//sources.list

# Add third-party repositories (Docker and Brave Browser)
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"| sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
sudo apt install -y brave-browser docker.io

# Add Arkenfox user.js for Firefox privacy and security configuration
mkdir -p /etc/firefox/pref
curl -fsSL https://raw.githubusercontent.com/arkenfox/user.js/master/user.js -o /etc/firefox/pref/user.js

# Configure Firefox to use the Arkenfox user.js
echo 'pref("general.config.obscure_value", 0);' >> /etc/firefox/pref/vendor-user.js
echo 'pref("general.config.filename", "user.js");' >> /etc/firefox/pref/vendor-user.js

# Configure system settings (example: swappiness)
echo "vm.swappiness=10" >> /etc/sysctl.conf

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
  build-essential \
  clang \
  cmake \
  g++ \
  gedit \
  gimp \
  htop \
  make \
  ncdu \
  neofetch \
  net-tools \
  tmux \
  tree \
  vlc

wget https://releases.hyper.is/download/deb
sudo dpkg -i deb
rm deb

# Install Oh-My-Zsh:
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme for Oh-My-Zsh:
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Virtualbox and veracrypt dependencies
sudo apt install -y \
  acpid \
  gcc \
  libccid \
  libpcre2-32-0 \
  libqt5help5 \
  libqt5opengl5 \
  libqt5sql5 \
  libqt5xml5 \
  libwxbase3.2-1 \
  libwxgtk3.2-1 \
  linux-headers-amd64 \
  make \
  pcscd \
  perl \
  psmisc
wget https://download.virtualbox.org/virtualbox/7.0.12/virtualbox-7.0_7.0.12-159484~Debian~bookworm_amd64.deb -O virtualbox.deb
wget https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Debian-12-amd64.deb -O veracrypt.deb
sudo dpkg -i virtualbox.deb veracrypt.deb
rm *.deb
sudo usermod -aG vboxusers user

sudo apt install -y \
  dconf-editor \
  gnome-shell-extensions \
  gnome-tweaks \
  papirus-icon-theme

read -p "Always spoof MAC addresses? (y/n)" answer
if [ "$answer" == "y" ]; then
  sudo cp etc/systemd/network/01-mac.link /etc/systemd/network/
fi

# change settings for power management
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 900
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
gsettings set org.gnome.desktop.session idle-delay 180

# night light
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2137
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 0.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 0.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"

gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'

# Allow touchpad touch
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# Set keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | \
sed -e "s|\']|\', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']|")" && \
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
name 'Open Terminal' && \
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
command 'gnome-terminal' && \
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
binding '<Super>t'
