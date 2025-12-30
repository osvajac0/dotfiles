#interactive mode I don't know how it works
[[ $- != *i* ]] && return

#Prompt
#PS1='\[\e[38;5;245;1;2m\]\W\[\e[0m\]  \[\e[38;5;245;1;2m\]\\$\[\e[0m\]  '
#export PS1="$(tput setab 16)\t$(tput setab 17) \w$(tput sgr 0) "
#export PS2="$(tput setab 17)>$(tput sgr 0) "
#PS1='\[\e[48;5;232;1m\]Integer\[\e[22m\] \[\e[1m\]\W\[\e[22m\] \[\e[0m\] '
PS1='\[\e[1m\][\u@\h\[\e[0m\] \[\e[1m\]\W]\\$\[\e[0m\] '

#Exports 
export PATH="$HOME/.local/bin/:/usr/local/bin/:$PATH"
export MICRO_TRUECOLOR=1

# Aliases
alias gp='git push -v'
alias ga='git add -v'
alias gc='git commit -v'
alias ls='ls --color=auto -t'
alias py='python3'
alias pip='pip3'
alias ytdl='youtube-dl'
alias docker='sudo docker'
alias open='xdg-open'
alias sudo='sudo -p "$(printf "\033[1;31mPassword: \033[0;0m" )"'
alias rm='printf "\033[1;31m" && rm -rIv'
alias cp='printf "\033[1;32m" && cp -rv'
alias mv='printf "\033[1;34m" && mv -v'
alias mkdir='printf "\033[1;33m" && mkdir -v'
alias rmdir='printf "\033[1;35m" && rmdir -v'
alias c='clear'
alias bat="bat --theme=ansi"
alias v='nvim'
alias cwp='feh --bg-fill'
alias pac='pacman -S'
alias soundux='flatpak run io.github.Soundux'

# Restore pywal colors on startup
[ -f "${HOME}/.cache/wal/sequences" ] && cat "${HOME}/.cache/wal/sequences"


