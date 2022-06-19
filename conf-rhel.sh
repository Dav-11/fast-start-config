#!/bin/bash

declare -i K8=0
declare -i BASE_PROGRAMMING=1
declare -i FLUTTER=0
declare -i SYSTEM=0
declare -i NETWORK=1
declare -i CHROME=1
declare -i DOCKER=1
declare -i WALLPAPER=1
declare -i POPSHELL=1

# update
printf "[%s] Updating apt and upgrade packets... \n" "$(date +'%D%_H:%M')"
sudo dnf -y update

# uninstall built in apps
printf "[%s]\n ###############################\n\n Removing Bloatware... \n\n ###############################\n" "$(date +'%D%_H:%M')"



# remove unused dependencies
printf "[%s] Removing unused dependencies... \n" "$(date +'%D%_H:%M')"
yes | sudo apt autoremove


# install applications
printf "[%s]\n ###############################\n\n Installing General Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"

printf "[%s] Installing VLC... \n" "$(date +'%D%_H:%M')"
sudo dnf install -y vlc

printf "[%s] Installing Curl... \n" "$(date +'%D%_H:%M')"
sudo dnf -y install curl

printf "[%s] Installing Neofetch... \n" "$(date +'%D%_H:%M')"
sudo dnf -y install neofetch

printf "[%s] Installing Snapd... \n" "$(date +'%D%_H:%M')"
sudo dnf -y install snapd

printf "[%s] Installing Git... \n" "$(date +'%D%_H:%M')"
sudo dnf -y install git

if [ "$NETWORK" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing NEWTORK Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Easyssh... \n" "$(date +'%D%_H:%M')"
	flatpak install flathub com.github.muriloventuroso.easyssh
fi

if [ "$BASE_PROGRAMMING" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing BASE_PROGRAMMING Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing JDK... \n" "$(date +'%D%_H:%M')"
	sudo dnf -y install java-latest-openjdk

    printf "[%s] Installing GO... \n" "$(date +'%D%_H:%M')"
	sudo dnf -y install golang

    printf "[%s] Installing Rust... \n" "$(date +'%D%_H:%M')"
	sudo dnf -y install rust cargo

    printf "[%s] Installing VSCode... \n" "$(date +'%D%_H:%M')"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update
    sudo dnf -y install code

fi

if [ "$FLUTTER" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing Flutter... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Flutter... \n" "$(date +'%D%_H:%M')"
	sudo snap install flutter --classic
fi

if [ "$CHROME" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing CHROME... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Chrome... \n" "$(date +'%D%_H:%M')"
	sudo dnf install fedora-workstation-repositories
	sudo dnf config-manager --set-enabled google-chrome
    sudo dnf -y install google-chrome-stable
fi

if [ "$DOCKER" -gt "0" ]
then
    printf "[%s]\n ###############################\n\n Installing DOCKER... \n\n ###############################\n" "$(date +'%D%_H:%M')"

    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo groupadd docker
    sudo usermod -aG docker $USER

    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
fi

if [ "$SYSTEM" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing SYSTEM Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Powershell... \n" "$(date +'%D%_H:%M')"
	sudo snap install powershell
fi

if [ "$K8" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing KUBERNETES Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Lens... \n" "$(date +'%D%_H:%M')"
	sudo snap install kontena-lens --classic
fi

if [ "$WALLPAPER" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Downloading additional wallpaper... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
    sudo su
    cd /usr/share/backgrounds/

	printf "[%s] Downloading wallpaper from ParrotSec... \n" "$(date +'%D%_H:%M')"
    git clone https://github.com/ParrotSec/parrot-wallpapers.git
    cd parrot-wallpaper/
    rm -rf debian/
    rm -f Makefile
    rm -f parrot-wallpapers.xml
    mv background/* .
    cd /usr/share/backgrounds/

    printf "[%s] Downloading wallpaper from Kali... \n" "$(date +'%D%_H:%M')"
    mkdir kali
    cd kali/
    wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2022/backgrounds/kali/kali-actiniaria-16x9.png?inline=false
    cd /usr/share/backgrounds/

fi

if [ "$POPSHELL" -gt "0" ]
then

    sudo dnf -y install gnome-tweak-tool
    sudo dnf -y install gnome-shell-extension-pop-shell xprop
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize,minimize:appmenu'

fi


printf "[%s] Done, Have a nice day! \n" "$(date +'%D%_H:%M')"