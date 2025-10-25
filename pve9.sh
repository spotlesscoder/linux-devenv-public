#!/bin/bash

# Add Proxmox VE repository configuration
cat << EOF > /etc/apt/sources.list.d/pve-enterprise.sources
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
EOF

# Add Ceph Squid
cat << EOF > /etc/apt/sources.list.d/ceph.sources
Types: deb
URIs: http://download.proxmox.com/debian/ceph-squid
Suites: trixie
Components: no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
EOF

echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/44noextrapackages
echo 'APT::Install-Suggests "false";' > /etc/apt/apt.conf.d/44noextrapackages
echo "Disable apt recommends and suggests (/etc/apt/apt.conf.d/44noextrapackages)"

apt install -y \
  curl \
  ffmpeg \
  jq \
  ncdu \
  p7zip-full \
  sed \
  tmux \
  tree \
  vim \
  wget \
  zsh
