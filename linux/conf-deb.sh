#!/bin/bash

declare -i K8=0
declare -i BASE_PROGRAMMING=1
declare -i NETWORK=1
declare -i CHROME=1
declare -i DOCKER=1
declare -i WALLPAPER=1

LOG_FILE=$(pwd)/installer.log

# update
printf "[%s] Updating apt and upgrade packets... \n" "$(date +'%D%_H:%M')"
sudo apt update && sudo apt -y upgrade

# disable suspension
#printf "[%s]\n ###############################\n\n disabling suspension... \n\n ###############################\n" "$(date +'%D%_H:%M')"
#yes |sudo apt install gconf2


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

# install applications
printf "[%s]\n ###############################\n\n Installing General Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"

printf "[%s] Installing VLC... \n" "$(date +'%D%_H:%M')"
sudo snap install vlc #vlc

printf "[%s] Installing Curl... \n" "$(date +'%D%_H:%M')"
sudo apt -y install curl

printf "[%s] Installing FastFetch... \n" "$(date +'%D%_H:%M')"
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt -y install fastfetch

printf "[%s] Installing Git... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo apt -y install git

printf "[%s] Installing FatPak... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo apt -y install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

printf "[%s] Installing Helix editor... \n" "$(date +'%D%_H:%M')"
sudo snap install helix --classic

printf "[%s] Installing Zellij... \n" "$(date +'%D%_H:%M')"
sudo snap install zellij --classic

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

# man
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null

# https://github.com/alacritty/alacritty/blob/master/INSTALL.md

# copy config_file
mkdir -p "$HOME"/.config/alacritty
curl -fsSL https://raw.githubusercontent.com/Dav-11/fast-start-config/main/config_files/alacritty.toml -o "$HOME"/.config/alacritty/alacritty.toml


printf "[%s]\n ###############################\n\n Installing BASE_PROGRAMMING Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE

printf "[%s] Installing Go... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo apt -y install golang-go

printf "[%s] Installing VSCode... \n" "$(date +'%D%_H:%M')"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt -y install apt-transport-https
sudo apt -y update
sudo apt -y install code


if [ "$NETWORK" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing NEWTORK Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Easyssh... \n" "$(date +'%D%_H:%M')"
	flatpak install flathub com.github.muriloventuroso.easyssh

fi

if [ "$CHROME" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing CHROME Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Chrome... \n" "$(date +'%D%_H:%M')"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt -y install ./google-chrome-stable_current_amd64.deb
fi

if [ "$DOCKER" -gt "0" ]
then
    printf "[%s]\n ###############################\n\n Installing DOCKER... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE

	curl -fsSL https://get.docker.com -o get-docker.sh
 	sudo sh get-docker.sh
	rm -f get-docker.sh
fi

if [ "$WALLPAPER" -gt "0" ]
then
    curl -s https://raw.githubusercontent.com/Dav-11/fast-start-config/main/extra/wallpaper-downloader.sh | bash -f '/usr/share/backgrounds/'
fi

printf "[%s] Done, Have a nice day! \n" "$(date +'%D%_H:%M')"
