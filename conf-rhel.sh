#!/bin/bash

declare -i K8=0
declare -i BASE_PROGRAMMING=1
declare -i FLUTTER=0
declare -i SYSTEM=0
declare -i NETWORK=1
declare -i CHROME=1
declare -i DOCKER=1
declare -i WALLPAPER=1
declare -i CUSTOMIZE_DE=1

LOG_FILE=$(pwd)/installer.log

# update
printf "[%s] Updating all packets... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo dnf -y update | tee -a $LOG_FILE

# uninstall built in apps
printf "[%s]\n ###############################\n\n Removing Bloatware... \n\n ###############################\n" "$(date +'%D%_H:%M')"



# remove unused dependencies
printf "[%s] Removing unused dependencies... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo dnf -y autoremove >> $LOG_FILE


# install applications
printf "[%s]\n ###############################\n\n Installing General Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE

printf "[%s] Installing VLC... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo dnf install -y vlc >> $LOG_FILE

printf "[%s] Installing Curl... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo dnf -y install curl >> $LOG_FILE

printf "[%s] Installing Neofetch... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo dnf -y install neofetch >> $LOG_FILE

printf "[%s] Installing Snapd... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo dnf -y install snapd >> $LOG_FILE

printf "[%s] Installing Git... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo dnf -y install git >> $LOG_FILE

printf "[%s] Flatpak setup... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if [ "$NETWORK" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing NEWTORK Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	
	printf "[%s] Installing Easyssh... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	flatpak install flathub com.github.muriloventuroso.easyssh >> $LOG_FILE
fi

if [ "$BASE_PROGRAMMING" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing BASE_PROGRAMMING Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	
	printf "[%s] Installing JDK... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	sudo dnf -y install java-latest-openjdk >> $LOG_FILE

    printf "[%s] Installing GO... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	sudo dnf -y install golang >> $LOG_FILE

    printf "[%s] Installing Rust... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	sudo dnf -y install rust cargo >> $LOG_FILE

    printf "[%s] Installing VSCode... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update >> $LOG_FILE
    sudo dnf -y install code >> $LOG_FILE

fi

if [ "$FLUTTER" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing Flutter... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	
	printf "[%s] Installing Flutter... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	sudo snap install flutter --classic
fi

if [ "$CHROME" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing CHROME... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	
	printf "[%s] Installing Chrome... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	sudo dnf -y install fedora-workstation-repositories >> $LOG_FILE
	sudo dnf config-manager --set-enabled google-chrome 
    sudo dnf -y install google-chrome-stable >> $LOG_FILE
fi

if [ "$DOCKER" -gt "0" ]
then
    printf "[%s]\n ###############################\n\n Installing DOCKER... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE

    sudo dnf -y install dnf-plugins-core >> $LOG_FILE
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin >> $LOG_FILE

    sudo groupadd docker
    sudo usermod -aG docker $USER

    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
fi

if [ "$SYSTEM" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing SYSTEM Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	
	printf "[%s] Installing Powershell... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	sudo snap install powershell >> $LOG_FILE
fi

if [ "$K8" -gt "0" ]
then
	printf "[%s]\n ###############################\n\n Installing KUBERNETES Apps... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	
	printf "[%s] Installing Lens... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	sudo snap install kontena-lens --classic
fi

if [ "$CUSTOMIZE_DE" -gt "0" ]
then
    printf "[%s]\n ###############################\n\n Customizing Desktop Env... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
	
	printf "[%s] Installing PopShell... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
    sudo dnf -y install gnome-tweak-tool >> $LOG_FILE
    sudo dnf -y install gnome-shell-extension-pop-shell xprop >> $LOG_FILE

    printf "[%s] Installing Caffeine... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
    sudo dnf -y install caffeine >> $LOG_FILE

    printf "[%s] Adding window buttons... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize,minimize:appmenu'

fi

if [ "$WALLPAPER" -gt "0" ]
then
    curl -s https://raw.githubusercontent.com/Dav-11/linux-conf/main/wallpaper-downloader.sh | bash
fi

printf "[%s] Done, Have a nice day! \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE