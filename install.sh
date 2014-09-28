#! /bin/bash

# Brian Cain
#
# A simple bash script for setting up
# an Operating System with my dotfiles

set OSPACKMAN=''

# Function to determine package manager
function os_type() {
  which yum > /dev/null && {
    echo "yum"
    export OSPACKMAN="yum"
    return;
  }
  which apt-get > /dev/null && {
    echo "apt-get"
    export OSPACKMAN="aptget"
    return;
  }
  which brew > /dev/null && {
    echo "homebrew"
    export OSPACKMAN="homebrew"
    return;
  }
}

echo "Setting up Operating System..."

set -e
(
  os_type

  # general package array
  declare -a packages=('vim' 'git' 'tree' 'htop' 'wget' 'curl')

  # this might get messy if more automated services come into play
  if [[ $MUTT_INSTALL == "true" ]]; then
    packages=("${packages[@]}" "mutt")
  fi

  if [[ $OSPACKMAN == "homebrew" ]]; then
    echo "You are running homebrew."
    echo "Using Homebrew to install packages..."
    brew update
    brew install ${packages[@]} the_silver_searcher
  elif [[ "$OSPACKMAN" == "yum" ]]; then
    echo "You are running yum."
    echo "Using apt-get to install packages...."
    sudo yum install ${packages[@]} rake zsh
  elif [[ "$OSPACKMAN" == "aptget" ]]; then
    echo "You are running apt-get"
    echo "Using apt-get to install packages...."
    sudo apt-get install ${packages[@]} rake zsh
  else
    echo "Could not determine OS. Exiting..."
    exit 1
  fi

  echo "Installing oh-my-zsh"
  source update-zsh.sh
  echo "Installing dotfiles"
  rake install
  mkdir -p ~/.vim/colors
  cp vim-colors/256_jungle.vim ~/.vim/colors/256_jungle.vim
  echo "Installing vim vundles..."
  vim +BundleInstall +qall
  echo "Changing shells to ZSH"
  chsh -s /bin/zsh
  echo "Reloading session"
  exec zsh

  echo "Operating System setup complete."
)
