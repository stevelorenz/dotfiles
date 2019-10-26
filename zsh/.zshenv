# ================================================
# Defines Environment Variables
# ================================================

# Export System Path
# Directories are searched from left to right.
# ------------------------------------------------
# - Load pyenv for python version management
if [[ -d ~/.pyenv/ ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  # init pyenv and virtualenv plugin
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# - Add local bin folders
export PATH=$HOME/bin:/usr/local/bin:$PATH
# ------------------------------------------------
