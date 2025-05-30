CONFIG_PATH="${HOME}/.config"

######
# ALIAS
######
export LS_OPTIONS='--color=auto'
alias ll='ls $LS_OPTIONS -alF'
alias la='ls $LS_OPTIONS -A'
alias l='ls $LS_OPTIONS -CF'

######
# ZSH config
######
source <("$CONFIG_PATH"/zsh/*)

######
# Autocomplete
######
source <("$CONFIG_PATH"/autocomplete/*)

######
# Starship
######
eval "$(starship init zsh)"
