# ================================================
# BASH Configuration File
# TODO: Update the bashrc
# ================================================

stty -ixon      # Disable ctrl-s and ctrl-q.
shopt -s autocd # Allows you to cd into directory merely by typing the directory name.

# Customised Prompt
# ----------------------------------------------------------
# show git branch information
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# set prompt
# export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
# ----------------------------------------------------------

# Alias
# ----------------------------------------------------------
[ -f "$HOME/.custom_aliases.sh" ] && source "$HOME/.custom_aliases.sh"
# ----------------------------------------------------------

# Color
# ----------------------------------------------------------
# cyan for ls directories
LS_COLORS=$LS_COLORS:'di=0;36:'
export LS_COLORS
# ----------------------------------------------------------

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
