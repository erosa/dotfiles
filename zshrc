export EDITOR='vim'
if [ -d "/usr/local/homebrew" ]; then
  export PATH="$HOME/bin:$HOME/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:$PATH"
else
  export PATH="$HOME/bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:$PATH"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# My custom theme
ZSH_THEME="eric"
LSCOLORS="gxfxcxdxbxegedabagacad"

if hash brew 2>/dev/null; then
  if [ -f `brew --prefix`/Cellar/z/1.9/etc/profile.d/z.sh ]; then
    . `brew --prefix`/Cellar/z/1.9/etc/profile.d/z.sh
  fi
else
  . ~/.z.sh
fi

source $ZSH/oh-my-zsh.sh
plugins=(osx ruby rake)

if hash rbenv 2>/dev/null; then
  eval "$(rbenv init -)"
fi


# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# don't expand aliases _before_ completion has finished
setopt complete_aliases

# Show completion on first TAB
setopt menucomplete
#unalias git



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
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

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

# For fixing ssh on tmux
fixssh() {
    eval $(tmux show-env |sed -n 's/^\(SSH_[^=]*\)=\(.*\)/export \1="\2"/p')
}

export PROMPT='[%D{%H:%M:%S}][$USER@$(hostname -f)]%{$fg[cyan]%}[%~% ]%{$reset_color%}%B$%b '
