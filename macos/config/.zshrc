
CONFIG_PATH="~/.config"

source "$CONFIG_PATH"/p10k/p10k_config

######
# ALIAS
######
export LS_OPTIONS='--color=auto'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

######
# ZSH config
######
source "$CONFIG_PATH"/zsh/zsh_power_conf
