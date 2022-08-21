#!/bin/sh

LOG_FILE=$(pwd)/installer.log

# install homebrew
printf "[%s] Installing Homebrew... \n" "$(date +'%D%_H:%M')"                                       | tee -a $LOG_FILE
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"     | tee -a $LOG_FILE

# install vscode
printf "[%s] Installing Visual Studio Code... \n" "$(date +'%D%_H:%M')"                             | tee -a $LOG_FILE
brew install --cask visual-studio-code                                                              | tee -a $LOG_FILE

# install dbeaver-community
printf "[%s] Installing Dbeaver Community... \n" "$(date +'%D%_H:%M')"                              | tee -a $LOG_FILE
brew install --cask dbeaver-community                                                               | tee -a $LOG_FILE

# install iTerm2
printf "[%s] Installing iTerm2... \n" "$(date +'%D%_H:%M')"                                         | tee -a $LOG_FILE
brew install --cask iterm2                                                                          | tee -a $LOG_FILE

# install firefox
printf "[%s] Installing Firefox... \n" "$(date +'%D%_H:%M')"                                        | tee -a $LOG_FILE
brew install --cask firefox                                                                         | tee -a $LOG_FILE

# install alfred
printf "[%s] Installing Alfred... \n" "$(date +'%D%_H:%M')"                                         | tee -a $LOG_FILE
brew install --cask alfred                                                                          | tee -a $LOG_FILE

# install docker-desktop
printf "[%s] Installing Docker Desktop... \n" "$(date +'%D%_H:%M')"                                 | tee -a $LOG_FILE
brew install --cask docker                                                                          | tee -a $LOG_FILE

# install postman
printf "[%s] Installing Postman... \n" "$(date +'%D%_H:%M')"                                        | tee -a $LOG_FILE
brew install --cask postman                                                                         | tee -a $LOG_FILE