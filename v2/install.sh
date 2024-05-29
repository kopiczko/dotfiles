#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly dir

cd "${dir}"

mk_link() {
    if [[ $# -ne 2 ]]; then
        echo "usage: mk_link SRC DST" >&2
        exit 1
    fi

    local s=$1; shift
    local t=$1; shift

    if [[ -h "$t" ]] && [[ "$(readlink "$t")" == "$s" ]]; then
        printf "I %-60s exists and links to %s\n" "$t" "$s"
        return 0
    fi
    if [[ -h "$t" ]]; then
        printf "E %-60s exists but links to $(readlink "$t"), needs to be FIXED manually\n" "$t"
        return 1
    fi
    if [[ -e "$t" ]]; then
        printf "E %-60s exists but it is not a link, needs to be FIXED manually\n" "$t"
        return 1
    fi
    printf "I %-60s does not exist, creating link to %s\n" "$s" "$t"

    [[ ! -e "$(dirname "$t")" ]] && mkdir -p "$(dirname "$t")"
    ln -s "$s" "$t"
}

code_dir="${HOME}/.config/Code"
if [[ -d "${HOME}/Library/Application Support" ]] ; then
    code_dir="${HOME}/Library/Application Support/Code"
fi
mkdir -p "${code_dir}/User"
while IFS= read -r -d '' f ; do
    mk_link "${f}" "${code_dir}/${f#${dir}/apps/Code/}"
done <   <(find "${dir}/apps/Code" -type f -print0)
