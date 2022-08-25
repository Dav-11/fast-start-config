#!/bin/bash

# get shell config
case "${SHELL}" in
  */bash*)
    if [[ -r "${HOME}/.bash_profile" ]]
    then
      shell_profile="${HOME}/.bash_profile"
    else
      shell_profile="${HOME}/.profile"
    fi
    ;;
  */zsh*)
    shell_profile="${HOME}/.zprofile"
    ;;
  *)
    shell_profile="${HOME}/.profile"
    ;;
esac

echo shell_profile: ${shell_profile}

UNAME_MACHINE="$(/usr/bin/uname -m)"

if [[ "${UNAME_MACHINE}" == "arm64" ]]
then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
fi

echo HOMEBREW_PREFIX: ${HOMEBREW_PREFIX}

# enable brew
echo 'eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >> ${shell_profile}
eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"