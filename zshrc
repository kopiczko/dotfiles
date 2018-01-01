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

if [[ $OSTYPE == darwin* ]]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

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

# Enable pyenv.
if [[ -d ~/.pyenv ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    export PATH="${PYENV_ROOT}/shims:${PATH}"
fi

# Enable rbenv.
if [[ -d ~/.rbenv ]]; then
    export RBENV_ROOT="$HOME/.rbenv"
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    export PATH="${RBENV_ROOT}/shims:${PATH}"
fi

source $HOME/.aliases
source $HOME/.envs
