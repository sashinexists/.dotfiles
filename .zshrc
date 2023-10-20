#!/bin/zsh
# -----------------------------
# Environment Variables
# -----------------------------
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="${HOME}/.oh-my-zsh"
export EDITOR="/usr/local/bin/hx"
export NVM_DIR="$HOME/.nvm"
export ERL_AFLAGS="-kernel shell_history enabled"




# -----------------------------
# Oh My ZSH plugins
# -----------------------------
plugins=(taskwarrior colored-man-pages)

# -----------------------------
# Core Configurations
# -----------------------------
bindkey -v
export KEYTIMEOUT=1
source $ZSH/oh-my-zsh.sh
autoload -U +X bashcompinit && bashcompinit



# -----------------------------
# Aliases
# -----------------------------
alias open="xdg-open"
alias tt="taskwarrior-tui"
alias today="task due:today"
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
alias new='new-task'
# Toolbox specific
if [ -z "$TOOLBOX_PATH" ]; then
    alias hx="/usr/local/bin/hx"
fi

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
# New Terminal Output
# -----------------------------
task +PENDING due.any: limit:4 order:due- list
