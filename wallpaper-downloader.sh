#!/bin/bash

printf "[%s]\n ###############################\n\n Downloading additional wallpaper... \n\n ###############################\n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE

BACKGROUNDS_FOLDER=$(pwd)/backgrounds/

while getopts f: flag
do
    case "${flag}" in
        f) BACKGROUNDS_FOLDER=${OPTARG};;
    esac
done

mkdir -p $BACKGROUNDS_FOLDER
cd $BACKGROUNDS_FOLDER

printf "[%s] Downloading wallpaper from ParrotSec... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo git clone https://github.com/ParrotSec/parrot-wallpapers.git temp
sudo mkdir parrot_wallpapers/
sudo mv temp/backgrounds/* parrot_wallpapers/
sudo rm -rf temp
cd $BACKGROUNDS_FOLDER

printf "[%s] Downloading wallpaper from PopOS!... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo git clone https://github.com/pop-os/wallpapers.git temp
sudo mkdir pop-os_wallpapers/
sudo mv temp/original/* pop-os_wallpapers/
sudo rm -rf temp
cd $BACKGROUNDS_FOLDER

printf "[%s] Downloading wallpaper from ElementaryOS... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo git clone https://github.com/elementary/wallpapers.git temp
sudo mkdir elementary_wallpapers/
sudo mv temp/backgrounds/* elementary_wallpapers/
sudo rm -rf temp
cd $BACKGROUNDS_FOLDER

printf "[%s] Downloading wallpaper from Kali... \n" "$(date +'%D%_H:%M')" | tee -a $LOG_FILE
sudo git clone https://gitlab.com/kalilinux/packages/kali-wallpapers.git temp
sudo mkdir kali_wallpapers/
for i in $(find 'temp/' -name '*.png' );
    do sudo mv "$i" kali_wallpapers/;
done;
sudo rm -rf temp
cd $BACKGROUNDS_FOLDER