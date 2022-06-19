#!/bin/bash

declare -i K8=0
declare -i PROGRAMMING=1
declare -i SYSTEM=1
declare -i NETWORK=1
declare -i EDGE=0
declare -i CHROME=1
declare -i AD=0
declare -i WALLPAPER=1

# update
printf "[%s] Updating apt and upgrade packets... \n" "$(date +'%D%_H:%M')"
sudo apt update && yes |sudo apt upgrade

# disable suspension
#printf "[%s]\n ###############################\n\n disabling suspension... \n\n ###############################\n" "$(date +'%D%_H:%M')"
#yes |sudo apt install gconf2


# uninstall built in apps
printf "[%s]\n ###############################\n\n Removing Bloatware... \n\n ###############################\n" "$(date +'%D%_H:%M')"

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
printf "[%s] Installing VSCode... \n" "$(date +'%D%_H:%M')"
sudo snap install --classic code #vs code

printf "[%s] Installing VLC... \n" "$(date +'%D%_H:%M')"
sudo snap install vlc #vlc

printf "[%s] Installing OBS... \n" "$(date +'%D%_H:%M')"
sudo snap install obs-studio

printf "[%s] Installing Zoom... \n" "$(date +'%D%_H:%M')"
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb
sudo rm -f zoom_amd64.deb

printf "[%s] Installing Telegram... \n" "$(date +'%D%_H:%M')"
sudo snap install telegram-desktop

printf "[%s] Installing Curl... \n" "$(date +'%D%_H:%M')"
sudo apt -y install curl

printf "[%s] Installing Neofetch... \n" "$(date +'%D%_H:%M')"
sudo apt -y install neofetch

# printf "[%s] Installing Play on Linux... \n" "$(date +'%D%_H:%M')"
# yes | sudo apt install playonlinux

if [ "$EDGE" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing EDGE Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Edge... \n" "$(date +'%D%_H:%M')"
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	yes |sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
	yes |sudo rm microsoft.gpg
	sudo apt update && yes |sudo apt install microsoft-edge-dev
fi

if [ "$CHROME" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing CHROME Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Chrome... \n" "$(date +'%D%_H:%M')"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	yes | sudo apt install ./google-chrome-stable_current_amd64.deb
fi


if [ "$PROGRAMMING" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing PROGRAMMING Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Umbrello... \n" "$(date +'%D%_H:%M')"
	sudo snap install umbrello #UML
	
	printf "[%s] Installing JDK... \n" "$(date +'%D%_H:%M')"
	yes |sudo apt install default-jdk #jdk
	
	printf "[%s] Installing Android Studio... \n" "$(date +'%D%_H:%M')"
	yes |sudo add-apt-repository ppa:maarten-fonville/android-studio
	sudo apt update
	yes |sudo apt install android-studio

	printf "[%s] Installing Flutter... \n" "$(date +'%D%_H:%M')"
	sudo snap install flutter --classic
fi

if [ "$SYSTEM" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing SYSTEM Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Powershell... \n" "$(date +'%D%_H:%M')"
	sudo snap install powershell
fi

if [ "$NETWORK" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing NEWTORK Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Easyssh... \n" "$(date +'%D%_H:%M')"
	flatpak install flathub com.github.muriloventuroso.easyssh
	
	printf "[%s] Installing Putty... \n" "$(date +'%D%_H:%M')"
	yes |sudo apt-get install putty -y #Putty
fi

if [ "$K8" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing KUBERNETES Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing Lens... \n" "$(date +'%D%_H:%M')"
	sudo snap install kontena-lens --classic
fi

if [ "$AD" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Configuring AD... \n\n ###############################\n" "$(date +'%D%_H:%M')"
	
	printf "[%s] Installing SSSD \n" "$(date +'%D%_H:%M')"
	yes | sudo apt install sssd-ad sssd-tools realmd adcli
	
	
fi

if [ "$WALLPAPER" -gt "0" ]
then
    curl -s https://raw.githubusercontent.com/Dav-11/linux-conf/main/wallpaper-downloader.sh | bash -f '/usr/share/backgrounds/'
fi

printf "[%s] Done, Have a nice day! \n" "$(date +'%D%_H:%M')"
