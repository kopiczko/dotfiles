version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
os="darwin"
arch="amd64"
bin="kubectl"
url="https://storage.googleapis.com/kubernetes-release/release/${version}/bin/darwin/amd64/kubectl"

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

set -ex

rm -rf /tmp/install_${bin}
mkdir -p /tmp/install_${bin}

mkdir /tmp/install_${bin}/bin
curl -fSL ${url} -o /tmp/install_${bin}/bin/${bin}

chmod +x /tmp/install_${bin}/bin/${bin}
mv /tmp/install_${bin}/bin/${bin} /usr/local/bin/${bin}

rm -rf /tmp/install_${bin}

# Completion.
kubectl completion zsh > "$HOME/.config/zsh/funcs_ephemeral/_kubectl"

echo "Installed in /usr/local/bin/${bin}"

# Uninstall:
#rm /usr/local/bin/kubectl
