SCRIPT_PATH="$HOME/.fleek"
#. $SCRIPT_PATH/zsh/.zshrc
source $SCRIPT_PATH/scripts.sh

# eza
# eza for ls
alias ls='eza'
# eza for ls -a
alias lsa='eza -a'
# eza for ls
alias ll='eza -l --git --header'
# eza for ls -la
alias lla='eza -la --git --icons --header'
# bat
# bat --plain for unformatted cat
alias catp='bat -p'
# replace cat with bat
alias cat='bat'
# zoxide
# zoxide for smart cd
alias cd='z'
