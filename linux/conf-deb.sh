#!/bin/bash

CONFIG_PATH="~/.config"
LOG_FILE=$(pwd)/installer.log

cd /opt/

update_os() {
    printf "[%s] Updating apt and upgrade packets... \n" "$(date +'%D%_H:%M')"
    sudo apt update && sudo apt -y upgrade
}

remove_bloat_ubuntu() {
    # uninstall built in apps (gnome)
    printf "[%s]\n ###############################\n\n Removing Gnome Bloatware... \n\n ###############################\n" "$(date +'%D%_H:%M')"

    printf "[%s] Uninstalling installer... \n" "$(date +'%D%_H:%M')"
    yes |sudo apt remove ubiquity

    printf "[%s] Uninstalling Mahjong... \n" "$(date +'%D%_H:%M')"
    yes |sudo apt --purge remove gnome-mahjongg

    printf "[%s] Uninstalling Sudoku... \n" "$(date +'%D%_H:%M')"
    yes |sudo apt --purge remove gnome-sudoku

    printf "[%s] Uninstalling Solitaire... \n" "$(date +'%D%_H:%M')"
    yes |sudo apt --purge remove aisleriot

    printf "[%s] Uninstalling Mines... \n" "$(date +'%D%_H:%M')"
    yes |sudo apt --purge remove gnome-mines

    printf "[%s] Uninstalling Videos... \n" "$(date +'%D%_H:%M')"
    yes |sudo apt --purge remove totem totem-plugins totem-common

    printf "[%s] Uninstalling Thunderbird... \n" "$(date +'%D%_H:%M')"
    yes |sudo apt --purge remove thunderbird

    printf "[%s] Uninstalling rhythmbox... \n" "$(date +'%D%_H:%M')"
    yes |sudo apt --purge remove rhythmbox

    # remove unused dependencies
    printf "[%s] Removing unused dependencies... \n" "$(date +'%D%_H:%M')"
    yes | sudo apt autoremove
}

install_basic_utils() {

    # install applications
    printf "[%s]\n ###############################\n\n Installing General Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"

    printf "[%s] Installing Curl... \n" "$(date +'%D%_H:%M')"
    sudo apt -y install curl apt-transport-https

    printf "[%s] Installing Git... \n" "$(date +'%D%_H:%M')"
    sudo apt -y install git

    printf "[%s] Installing zsh... \n" "$(date +'%D%_H:%M')"
    sudo apt -y install zsh
}

build_alacritty() {

    printf "[%s] Installing Rustup... \n" "$(date +'%D%_H:%M')"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    printf "[%s] Build Alacritty... \n" "$(date +'%D%_H:%M')"
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
    sudo apt install -y cmake \
	g++ \
	pkg-config \
	libfreetype6-dev \
	libfontconfig1-dev \
	libxcb-xfixes0-dev \
	libxkbcommon-dev \
	python3

    # build
    cargo build --release

    # desktop entry
    sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database

    # https://github.com/alacritty/alacritty/blob/master/INSTALL.md
}

copy_conf() {
    mkdir -p "$HOME"/.config

    git clone https://github.com/Dav-11/fast-start-config.git
    cd fast-start-config
    git submodule init
    cp -r .config/* "$CONFIG_PATH"/
    cd ..
    rm -rf fast-start-config
}

##############################################################
# MAIN
##############################################################

update_os
remove_bloat_ubuntu
install_basic_utils
copy_conf

build_alacritty


printf "[%s] Done, Have a nice day! \n" "$(date +'%D%_H:%M')"
