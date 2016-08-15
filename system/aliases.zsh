# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
# if $(gls &>/dev/null)
# then
#   alias ls="gls -F --color"
#   alias l="gls -lAh --color"
#   alias ll="gls -l --color"
#   alias la='gls -A --color'
# fi
# cmd
alias k='kill -9'
alias g='grep -nir'
alias t='type -a'
alias v='view'
alias vi='vim'
alias c='clear'
alias cat='ccat'
alias cp='cp -i'
alias mv='mv -i'
alias h='history'
alias ls='ls -F'
alias ll='ls -alF'
alias vh='vi /etc/hosts'
alias o='open -a "Google Chrome"'
alias hidden='ls -a | grep "^\."'
