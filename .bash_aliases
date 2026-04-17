[[ $- != *i* ]] && return

# Apt
alias aptinstall='sudo apt update && sudo apt install -y'
alias aptupgrade='sudo apt update && sudo apt upgrade -y'
alias aptsearch='sudo apt update && apt search'
alias aptclean='sudo apt clean && sudo rm -rf /var/lib/apt/lists/*'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph -10'
alias gd='git diff'

# Sistema
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias c='clear'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'

# Rede
alias ip='ip -c'
