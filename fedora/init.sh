#!/usr/bin/env bash

set -e
set -o pipefail

set -x

sudo dnf upgrade -y --refresh
sudo dnf install -y git neovim tmux
sudo dnf install -y @"C Development Tools and Libraries"
sudo dnf install -y podman podman-docker


sudo dnf install -y zsh
chsh -s $(which zsh) # This requries relogin/reboot


# --- ~/.local/bin

mkdir -p "${HOME}/.local/bin"

# --- enpass

sudo dnf config-manager --add-repo https://yum.enpass.io/enpass-yum.repo
sudo dnf install -y enpass

# --- snapd

sudo dnf install -y snapd
if [[ ! -d /snap ]] ; then
	sudo ln -s /var/lib/snapd/snap /snap
fi

# sudo snap install go --classic
# sudo snap install kubectl --classic
# sudo snap install slack
# sudo snap install --edge starship

# !!! Need to relogin/reboot now !!! #

# --- keyd

keyd_dir="${HOME}/Code/github.com/rvaiya/keyd"
keyd_config_file="/etc/keyd/default.conf"

if [[ ! -d "${keyd_dir}" ]] ; then
	mkdir -p "${keyd_dir}"
	git clone "https://github.com/rvaiya/keyd" "${keyd_dir}"
fi
pushd "${keyd_dir}"
git checkout master
git pull --tags
git checkout "v2.4.3"
make && sudo make install
popd
sudo systemctl enable keyd && sudo systemctl start keyd

if [[ ! -f "${keyd_config_file}" ]] ; then
	mkdir -p "$(dirname "${keyd_config_file}")"
	# TODO replace this part with download from dotfiles
	sudo touch "${keyd_config_file}"
	sudo chgrp keyd "${keyd_config_file}"
	sudo chmod g+rw "${keyd_config_file}"
fi

sudo usermod -a -G keyd "${USER}"

# 1. setup SSH key (from enpass)
#    SSH_ASKPASS=/usr/bin/ksshaskpass ssh-add </dev/null
# 2. run init2
