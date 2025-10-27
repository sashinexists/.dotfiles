#!/bin/zsh
# -----------------------------
# Environment Variables
# -----------------------------
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="${HOME}/.oh-my-zsh"
# export EDITOR="/usr/local/bin/hx"
export EDITOR=hx
export NVM_DIR="$HOME/.nvm"
export ERL_AFLAGS="-kernel shell_history enabled"
export FLYCTL_INSTALL="/var/home/sashin/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
export TERM=xterm-256color
export SIGNAL_PASSWORD_STORE=gnome-libsecret
# -----------------------------
# Oh My ZSH plugins
# -----------------------------
plugins=(taskwarrior colored-man-pages git fzf)

# -----------------------------
# Core Configurations
# -----------------------------
bindkey -v
export KEYTIMEOUT=1
source $ZSH/oh-my-zsh.sh
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
# bindkey -e '\C-e' 'EDITOR=command-edit edit-command-line'


custom_edit_command_line() {
  EDITOR=command-edit zle edit-command-line
}

zle -N custom_edit_command_line
bindkey -e '\C-e' custom_edit_command_line
# -----------------------------
# Aliases
# -----------------------------
alias open="xdg-open"
alias tt="taskwarrior-tui"
alias overdue="task due.before:today +PENDING"
alias today="task due:today"
alias tomorrow="task due:tomorrow"
alias tasks="task list"
alias z='zoxide'
alias l='exa'
alias idea="eureka"
alias man='LC_MESSAGES=en_US.UTF-8 man'
alias tldr='tldr -L en --color always'
alias zshrc='z ~/.dotfiles/ && hx .zshrc'
alias rc='zshrc'
alias lynx='toolbox run -c dev lynx'
alias dev='toolbox enter dev'
alias odm='toolbox enter webodm-dev'
alias new='new-task'
alias todo='task +PENDING due.any:  order:due- list'
alias backburner='task +PENDING due.none: list'
alias gp='gnuplot'
alias cd-exercism='cd /home/sashin/ドキュメント/プロジェクト/exercism && toolbox enter dev'
alias cat='bat'
alias work-database-start='pgcli postgresql://apadev:P9aC4GMehxZ3vpc@apa-db.postgres.database.azure.com:5432/postgres'
alias wd='pgcli postgresql://apadev:P9aC4GMehxZ3vpc@apa-db.postgres.database.azure.com:5432/postgres'
alias ws='work-server-start'
alias wf='work-frontend-start'
alias wh='work-hx-start'
alias fp='flatpak'
alias rp='rpm-ostree'


# -----------------------------
# Syntax Highlighting
# -----------------------------
source /var/home/sashin/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -----------------------------
# Third-Party Integrations
# -----------------------------
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# -----------------------------
# Prompt
# -----------------------------
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"


# -----------------------------
# Shell functions
# -----------------------------
unalias ls

cd() {
  if [ -t 1 ]; then
    z "$@"
  else
    builtin cd "$@"
  fi
}
AUTO_CD="z"
setopt autocd 

ls() {
  if [ -t 1 ]; then
    exa "$@"
  else
    /usr/bin/ls "$@"
  fi
}

hx() {
    if [ -z "$TOOLBOX_PATH" ]; then
        toolbox run -c dev hx "$@"
    else
      /usr/bin/hx "$@"
    fi
}

task() {
    if [ -z "$TOOLBOX_PATH" ]; then
        toolbox run -c dev task "$@"
    else
      /usr/local/bin/task "$@"
    fi
}

condense() {
    if [ -z "$TOOLBOX_PATH" ]; then
        toolbox run -c dev ~/.local/bin/condense-audio "$@"
    else
      ~/.local/bin/condense-audio "$@"
    fi
}


fu() {
    if [ -z "$TOOLBOX_PATH" ]; then
        toolbox run -c dev thefuck 
    else
      /usr/bin/thefuck
    fi
}


# -----------------------------
# New Terminal Output
# -----------------------------
task  +PENDING due.any: limit:4 order:due- list

# -----------------------------
# Use latest Node & NPM
# -----------------------------
nvm use stable

[ -f "/var/home/sashin/.ghcup/env" ] && source "/var/home/sashin/.ghcup/env" # ghcup-env

# Shell history recommendations from Martin Heinz
# https://martinheinz.dev/blog/110

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000



setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

export FZF_DEFAULT_COMMAND='ag --hidden -g ""'


HIST_STAMPS="yyyy-mm-dd"

eval $(thefuck --alias)

# pnpm
export PNPM_HOME="/var/home/sashin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
