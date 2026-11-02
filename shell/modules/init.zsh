ZSH_THEME=""
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Zsh has built-in completion — load compinit instead of bash_completion
autoload -Uz compinit && compinit

# Zsh completion for t(): delegate to dict's completion if available
compdef t=dict
