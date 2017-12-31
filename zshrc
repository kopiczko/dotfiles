# Debug startup time.
#
#     for in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
#     zsh -i -x -c exit

# Emacs mode.
bindkey -e

# One history for all open shells; store 10 000 entries. Use ^R and Alt-P.
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory
setopt sharehistory
setopt extendedhistory

# Activate the bash-style comments.
setopt interactivecomments

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

#export PATH=$HOME/bin:/usr/local/bin:$PATH
#export MANPATH="/usr/local/man:$MANPATH"

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

source $HOME/.aliases
source $HOME/.envs
