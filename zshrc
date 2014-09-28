export EDITOR='vim'
export PATH="$HOME/bin:$HOME/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# My custom theme
ZSH_THEME="eric"
LSCOLORS="gxfxcxdxbxegedabagacad"

source $ZSH/oh-my-zsh.sh

# OS Agnostic aliases
alias reload!='. ~/.zshrc'

alias df='df -h'
alias diff='colordiff'
alias grep='grep --color=auto'
alias ping='ping -c 2'
alias tail='tail -n100'
alias pmb='puppet module build'
alias fpull='!git fetch upstream && git merge @{u} --ff-only'
alias changelog='git log `git log -1 --format=%H -- CHANGELOG*`..; cat CHANGELOG*'

# Load additional config files based on the OS
if [[ $(uname) = "Darwin" ]]; then
  # Vagrant aliases
  alias v="VAGRANT_CWD=/s/v vagrant"
  alias vd='v destroy -f'
  alias vup='v up'
  alias vs='v suspend'
  alias vstat='v status'

  # Misc aliases
  alias updatedb='sudo /usr/libexec/locate.updatedb'
  alias ll='ls -liAFG'
  alias start_watchr='cd /s/pe-dev-scripts/workflow && watchr installer.watchr'
  alias be='bundle exec'
elif [[ $(uname) = "Linux" ]]; then
  alias ll='ls -liAFG --color'
fi
