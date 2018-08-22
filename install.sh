sudo apt -y install git cppcheck arc-theme cifs-utils \
	    byobu clang-format exuberant-ctags python3-pip \
	    openvpn network-manager-openvpn-gnome resolvconf \
	  lxappearance stow emacs vim lilypond markdown fonts-inconsolata

sudo pip3 install flake8 autopep8 mypy music21

git submodule update --init --recursive

#
# Powerline fonts
#
pushd /tmp
git clone https://github.com/powerline/fonts.git
cd fonts && ./install.sh
popd

pushd $HOME
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
popd


