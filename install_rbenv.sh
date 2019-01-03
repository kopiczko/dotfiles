#!/usr/bin/env bash -e

version=
bin="rbenv"

echo "skipping installing ${bin}"
echo "use brew ruby instead"
exit 1

git_url="git@github.com:rbenv/rbenv.git"

if [[ -d ~/.$bin ]]; then
    cd ~/.$bin && git checkout master && git pull
else
    git clone $git_url ~/.$bin
fi

# Finds tags following semver pattern vx.y.z, sorts them and takes the latest.
version=$(cd ~/.$bin && git tag | egrep 'v[0-9]+\.[0-9]+\.[0-9]+' | xargs | tr ' ' '\n' | sort -rV | head -1)

cd ~/.$bin && git checkout "$version"

# Uninstall:
#rm -rf ~/.rbenv
