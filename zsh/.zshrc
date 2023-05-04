# Oh_My_Zsh Configuration
# ----------------------------------------------------------
# Location on oh my zsh dir
export ZSH="$HOME/.oh-my-zsh"

# Default prompt theme
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# Use upgrade_oh_my_zsh command
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Custom settings, use default dir
# ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	colored-man-pages
	extract
	z
	zsh-autosuggestions
	zsh-completions
)

# Auto load and init completions
source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit
# ----------------------------------------------------------

# Custom Configuration
# ----------------------------------------------------------
# Set language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export SUDO_EDITOR=vim
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi

# Add local bin folders
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Load custom aliases
[ -f ~/.custom_aliases.sh ] && source ~/.custom_aliases.sh

# BCC tracing tools and man pages
if [[ -d /usr/share/bcc ]]; then
	export MANPATH="/usr/share/bcc/man:$MANPATH"
	export PATH="/usr/share/bcc/tools:$PATH"
fi

# Add paths of some common programming languages

## Java
if [[ -d "/usr/lib/jvm/default" ]]; then
	export JAVA_HOME=/usr/lib/jvm/default
	export PATH="$PATH:$JAVA_HOME/bin"
fi

## Groovy
if [[ -d "/usr/share/groovy" ]]; then
	export GROOVY_HOME=/usr/share/groovy
	export PATH="$PATH:$GROOVY_HOME/bin"
fi

## Golang
if [[ -d "$HOME/.go" ]]; then
	export GOPATH="$HOME/.go"
	export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"
fi

## Ruby Gem
if [[ -d "$HOME/.gem/ruby/3.0.0/" ]]; then
	export RUBYPATH="$HOME/.gem/ruby/3.0.0"
	export PATH="$PATH:$RUBYPATH/bin"
fi

## Rust Cargo
if [[ -d "$HOME/.cargo/" ]]; then
	export CARGOPATH="$HOME/.cargo"
	export PATH="$PATH:$CARGOPATH/bin"
fi

## C# Dotnet
if [[ -d "$HOME/.dotnet/tools" ]]; then
	export DOTNETPATH="$HOME/.dotnet/tools"
	export PATH="$PATH:$DOTNETPATH"
fi

## Typescript Deno
if [[ -d $HOME/.deno ]]; then
	export DENO_INSTALL="$HOME/.deno"
	export PATH="$DENO_INSTALL/bin:$PATH"
fi

# Use Ibus (I use Gnome and i3wm) for Chinese input
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
# ----------------------------------------------------------
