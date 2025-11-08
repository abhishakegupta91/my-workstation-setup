# Zsh Configuration
# This file is managed by Ansible workstation setup

# Disable compfix warnings
ZSH_DISABLE_COMPFIX="true"

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Oh My Zsh plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='micro'
export BROWSER='firefox'

# Custom aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Development aliases
alias dc='docker compose'
alias d='docker'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# Node Version Manager (NVM) - Cross-platform setup
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
    \. "$NVM_DIR/bash_completion"
fi

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Bigger history
export HISTSIZE=100000
export SAVEHIST=100000

# Smarter history behavior
setopt HIST_IGNORE_ALL_DUPS     # remove older dupes on save
setopt HIST_SAVE_NO_DUPS        # don't write dupes
setopt HIST_FIND_NO_DUPS        # no dupes in history search
setopt HIST_REDUCE_BLANKS       # trim extra spaces
setopt HIST_IGNORE_SPACE        # ignore commands starting with space
setopt INC_APPEND_HISTORY       # append immediately
setopt SHARE_HISTORY            # share across sessions
setopt EXTENDED_HISTORY         # keep timestamps

# Platform-specific configurations
case "$(uname -s)" in
    Darwin*)
        # macOS specific settings
        if [ -d "/opt/homebrew" ]; then
            export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
        fi
        if [ -d "/usr/local/opt/mysql-client/bin" ]; then
            export PATH="/usr/local/opt/mysql-client/bin:$PATH"
        fi
        ;;
    Linux*)
        # Linux specific settings
        if [ -d "/snap/bin" ]; then
            export PATH="/snap/bin:$PATH"
        fi
        ;;
esac

# Development environment configurations
if [ -f "$HOME/.local/bin/env" ]; then
    . "$HOME/.local/bin/env"
fi

# Optional: Add conda if it exists (cross-platform)
if [ -d "$HOME/miniconda3" ]; then
    export PATH="$HOME/miniconda3/bin:$PATH"
    __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda3/etc/profile.d/conda.sh"
        fi
    fi
    unset __conda_setup
fi