#!/usr/bin/env bash


if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

version=$(curl -is 'https://github.com/Masterminds/glide/releases/latest' | grep "Location:")
version=$(echo ${version} | cut -d ' ' -f 2 | tr -d '[:space:]')
version=$(basename ${version})

os="$(go env GOOS)"

url="https://github.com/Masterminds/glide/releases/download/${version}/glide-${version}-darwin-386.tar.gz"

echo "version: ${version}"
echo "os:      ${os}"
echo "url:     ${url}"
echo

mkdir glide
curl -Lo glide.tar.gz "${url}"
tar -C ./glide --strip-components 1 -xzvf ./glide.tar.gz 
chmod +x ./glide/glide
sudo mv ./glide/glide /usr/local/bin/
rm -rf ./glide ./glide.tar.gz

# Uninstall:
#rm -rf /usr/local/bin/glide
