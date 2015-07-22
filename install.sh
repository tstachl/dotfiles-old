#!/usr/bin/env bash
#
# The install script for my dotfiles. This is built on top of the project
# oh-my-fish (https://github.com/oh-my-fish/oh-my-fish). Mainly because it's a
# nice framework that allows for plugins and themes.
#
# Get started with:
#   curl -L https://github.com/tstachl/dotfiles/raw/master/install.sh | bash
#
# Currently supports
#   - Fish 2.0+ [fishshell.com] [github.com/fish-shell/fish-shell]

dot_path=~/.dotfiles
fish_path=~/.dotfiles/oh-my-fish
dotvim_path=~/.vim
config_path=~/.config/fish
base16_path=~/.config/base16-shell

black='\033[0;30m' # Black - Regular
red='\033[0;31m' # Red
green='\033[0;32m' # Green
yellow='\033[0;33m' # Yellow
blue='\033[0;34m' # Blue
purple='\033[0;35m' # Purple
cyan='\033[0;36m' # Cyan
white='\033[0;37m' # White
reset='\033[0m'    # Reset

# use: log $blue "Whatever you want to say"
log() {
  echo -e "${1}${2}${reset}"
}

command_exists() {
  type "$1" &> /dev/null ;
}

if ! command_exists dvtm ; then
  log $blue "Installing dvtm ..."
  if [ "$(uname)" == "Darwin" ]; then
    brew install dvtm &> /dev/null
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt-get install dvtm &> /dev/null
  fi
fi

if [ $? -ne 0 ]; then
  log $red "Something went wrong, couldn't install dvtm please instll manually."
  log $yellow "I'm still continuing with the install though."
fi

if ! command_exists abduco ; then
  log $blue "Installing abduco ..."
  if [ "$(uname)" == "Darwin" ]; then
    brew install abduco &> /dev/null
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt-get install abduco &> /dev/null
  fi
fi

if [ $? -ne 0 ]; then
  log $red "Something went wrong, couldn't install abduco please instll manually."
  log $yellow "I'm still continuing with the install though."
fi

log $white "Installing dotfiles for Thomas ..."
if [ -d $dot_path ]; then
  log $yellow "You already have the dotfiles installed."
  log $white "Remove ${dot_path} if you want to reinstall it."
  exit 0
fi

log $blue "Cloning remotes ..."
if command_exists git ; then
  git clone -b master "https://github.com/tstachl/dotfiles.git" $dot_path
  git clone -b master "https://github.com/oh-my-fish/oh-my-fish.git" $fish_path
  git clone -b master "https://github.com/chriskempson/base16-shell.git" $base16_path
else
  log $red "Git is not installed, can not continue."
  exit 1
fi

log $blue "Looking for an existing fish config ..."
if [ -f "${config_path}/config.fish" ]; then
  log $green "Found ${config_path}/config.fish"
  log $green "Backing up to ${config_path}/config.fish.orig"
  mv "${config_path}/config.fish" "${config_path}/config.fish.orig"
fi

log $blue "Adding default configuration file to ${config_path}/config.fish"
ln -s "${dot_path}/fish/config.fish" "${config_path}/config.fish"

log $green "Dotfiles are now installed."

# Test for a terminal!
fd=0   # stdin
if [[ -t "$fd" || -p /dev/stdin ]]; then
  exec fish < /dev/tty
fi
