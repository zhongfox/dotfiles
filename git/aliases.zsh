# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gcb='git copy-branch-name' #nice
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.

# git
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gck='git checkout'
alias gb='git branch'
alias gl='git log'
alias gshow='git show'
alias gthis='git rev-parse --abbrev-ref HEAD'
alias gpushthis='git push origin `gthis`'
alias gpullthis='git pull origin `gthis`'
alias gup='git remote update -p'
alias grest='git reset --hard HEAD@{1}'
