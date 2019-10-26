#######################################################################
#                           Custom Aliases                            #
#######################################################################

# If user is not root, pass commands via sudo
if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
    alias poweroff='sudo poweroff'
    alias updatedb='sudo updatedb'
fi

# Show hidden files
alias l.='ls -d .* --color=auto'

# A quick way to get out of current directory
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'

# Do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -I --preserve-root'

# Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Default editor
alias e='nvim'

# Vim "variants" on Ubuntu
##  Compiled with GTK2, for python2 and python3
alias vim-py2='vim.gtk-py2'
alias vim-py3='vim.gtk'

# Clear tmux-resurrect history
alias clear-resurrect='rm -rf ~/.tmux/resurrect/*'

# Always enable colored `grep` output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
