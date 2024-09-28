#!/bin/zsh

CONFIG_PATH="~/.config"
LOG_FILE=$(pwd)/installer.log

install() {
    local program=$1

    printf "[%s] Install $program... \n" "$(date +'%D%_H:%M')"
    brew install $program
}

install_cask() {
    local program=$1

    printf "[%s] Install $program... \n" "$(date +'%D%_H:%M')"
    brew install --cask $program
}

copy_file() {
    local source=$1
    local destination=$2

    dir="$destination"

    # Check if $destination is a file or a directory
    if [[ -f $destination ]]; then
        # If it's a file, extract its directory
        dir=$(dirname "$destination")
    fi

    # make sure path exists
    mkdir -p "$dir"

    printf "[%s] Copy $source -> $destination... \n" "$(date +'%D%_H:%M')"
    cp $source $destination
}

# Install brew
printf "[%s] Install Homebrew... \n" "$(date +'%D%_H:%M')"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


printf "[%s]\n ###############################\n\n Installing Terminal Stuff... \n\n ###############################\n" "$(date +'%D%_H:%M')"
install_cask font-hack-nerd-font
install_cask alacritty

install zsh-autosuggestions
install zsh-syntax-highlighting
install powerlevel10k
install btop
install fastfetch
install cpufetch
install zellij

#####
# copy config files
#####

# p10k
copy_file ./config/.p10k.zsh "$CONFIG_PATH"/p10k

# zsh
copy_file ./config/zsh_power_config "$CONFIG_PATH"/zsh/
copy_file ./config/.zshrc ~/

# alacritty
copy_file ./config/alacritty.toml "$CONFIG_PATH"/alacritty/


printf "[%s]\n ###############################\n\n Installing Dev Stuff... \n\n ###############################\n" "$(date +'%D%_H:%M')"
install_cask zed
install_cask visual-studio-code

install helix

#####
# copy config files
#####
copy_file ../config_files/helix.toml "$CONFIG_PATH"/helix/config.toml
copy_file ../config_files/zed.json "$CONFIG_PATH"/zed/settings.json

printf "[%s]\n ###############################\n\n Installing Container Stuff... \n\n ###############################\n" "$(date +'%D%_H:%M')"

install colima
install docker
install docker-completion
