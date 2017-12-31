#!/usr/bin/env bash -e

bin="pyenv"

git_url="git@github.com:pyenv/pyenv.git"

if [[ -d ~/.$bin/.git ]]; then
    cd ~/.$bin && git checkout master && git pull
else
    git clone $git_url ~/.$bin
fi

# Finds tags following semver pattern vx.y.z, sorts them and takes the latest.
version=$(cd ~/.$bin && git tag | egrep 'v[0-9]+\.[0-9]+\.[0-9]+' | xargs | tr ' ' '\n' | sort -rV | head -1)

cd ~/.$bin && git checkout "$version"

if [[ ! -L /usr/local/bin/${bin} ]] && [[ "$(readlink /usr/local/bin/${bin})" != "$HOME/.${bin}/bin/${bin}" ]]; then
    ln -s $HOME/.${bin}/bin/${bin} /usr/local/bin/${bin}
fi

# Uninstall:
#rm -rf ~/.pyenv
#rm -rf /usr/local/bin/pyenv
