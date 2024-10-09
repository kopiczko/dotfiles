# Debug startup time.
#
#     for in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
#     zsh -i -x -c exit

# Emacs mode.
bindkey -e

# One history for all open shells; store 10 000 entries. Use ^R and Alt-P.
HISTFILE=~/.zsh_history
HISTSIZE=SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Activate the bash-style comments.
setopt interactivecomments

# Highlight selected completion.
zstyle ':completion:*' menu select

# Autoload functions from:
#     - $HOME/.config/zsh/funcs
#     - $HOME/.config/zsh/funcs_ephemenral
fpath=($HOME/.config/zsh/funcs $fpath)
fpath=($HOME/.config/zsh/funcs_ephemeral $fpath)
for f in $(find $HOME/.config/zsh/funcs* -not -name '\.*' -type f); do
    autoload -Uz $(basename $f)
done

# Enable completion.
autoload compinit && compinit

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /opt/local/share/fzf/shell/key-bindings.zsh ] && source /opt/local/share/fzf/shell/key-bindings.zsh
[ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh

# Enable autosuggestions.
[[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f /opt/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /opt/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /opt/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /opt/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $HOME/.aliases
source $HOME/.envs
[ -f $HOME/.envs_volatile ] && source $HOME/.envs_volatile

source $HOME/src/kb/kopiczko/dotfiles/shrc

# zoxide
command -v zoxide 2>&1 >/dev/null && eval "$(zoxide init zsh)"
