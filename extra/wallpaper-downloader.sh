#!/bin/bash

printf "\n ###############################\n\n [%s] Downloading additional wallpaper... \n\n ###############################\n" "$(date +'%D_%H:%M')" | tee -a $LOG_FILE

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

# vars for kali
declare -i SIXTEEN_NINE=1
declare -i SIXTEEN_TEN=1
declare -i FOUR_THREE=0

sudo git clone https://gitlab.com/kalilinux/packages/kali-wallpapers.git temp
sudo mkdir kali_wallpapers/

if [ "$SIXTEEN_NINE" -gt "0" ]
then
    for i in $(find 'temp/' -name '*16x9.png' );
    do
        if [[ -L "$i" ]]; then
            printf ''
        else
            sudo mv "$i" kali_wallpapers/
        fi
    done;
fi

if [ "$SIXTEEN_TEN" -gt "0" ]
then
    for i in $(find 'temp/' -name '*16x10.png' );
    do
        if [[ -L "$i" ]]; then
            printf ''
        else
            sudo mv "$i" kali_wallpapers/
        fi
    done;
fi

if [ "$FOUR_THREE" -gt "0" ]
then
    for i in $(find 'temp/' -name '*4x3.png' );
    do
        if [[ -L "$i" ]]; then
            printf ''
        else
            sudo mv "$i" kali_wallpapers/
        fi
    done;
fi

sudo rm -rf temp
cd $BACKGROUNDS_FOLDER