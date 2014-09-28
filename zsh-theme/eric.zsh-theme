autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# If inside a Git repository, print its branch and state
git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "[${git_where#(refs/heads/|tags/)}]"
}

export PROMPT='[$USER@$(hostname -f)]%{$fg[cyan]%}[%~% ]%{$reset_color%}%B$%b '

precmd() {
  title "zsh" "%m" "%55<...<%~"
  echo -e "\033];$(hostname -f)\007"
  if ! [[ -z "$(ruby_version)" ]]
  then
    export RPROMPT='%{$fg[cyan]%}$(git_custom_status)%{$fg[white]%}[$(ruby_version)]%{$reset_color%}'
  else
    export RPROMPT='%{$fg[cyan]%}$(git_custom_status)%{$reset_color%}'
  fi
}
