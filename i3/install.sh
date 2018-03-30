#!/bin/bash

source_directory="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)"
echo "Adding syncthing PPA to apt"
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "Adding Riot PPA to apt"
sudo sh -c "echo 'deb https://riot.im/packages/debian/ artful main' > /etc/apt/sources.list.d/matrix-riot-im.list"
curl -L https://riot.im/packages/debian/repo-key.asc | sudo apt-key add -
echo "Update apt cache"
sudo apt update
sudo apt install i3 i3-wm i3status i3blocks suckless-tools feh compton gtk-chtheme \
    qt4-qtconfig sysstat acpi git automake build-essential gtk-doc-tools \
    gobject-introspection xbacklight scrot kbdd xautolock pavucontrol fonts-font-awesome \
    xscreensaver syncthing gsimplecal ssh-askpass riot-web

# Install playerctl
cd /tmp && rm -rf playerctl
git clone https://github.com/acrisci/playerctl.git
cd playerctl
./autogen.sh
make && sudo make install

# Install xkblayout-state
cd /tmp && rm -rf xkblayout-state
git clone https://github.com/nonpop/xkblayout-state.git
cd xkblayout-state
make -j$(nproc)
cp xkblayout-state ${source_directory}/
