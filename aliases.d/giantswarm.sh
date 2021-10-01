#!/usr/bin/env bash


alias pluigi='pbpaste | command luigi --no-color | vi -'
alias srag='sra -n giantswarm'

function setimg() {(
    if [ $# -ne 1 ] ; then
        echo >&2 "usage: setimg INSTALLATION"
        return 2
    fi

    set -o errexit
    set -o nounset
    set -o pipefail

    local installation="$1"

    local app="${PWD##*/}"
    local image="giantswarm/${app}:pawel-$(date -u +%Y%m%d%H%M%S)"
    local sep="$(perl -E "print '-' x 79")"

    local cmds=(
    "make build-docker"
    "docker tag "${app}:$(architect project version)" $image"
    "docker push $image"
    "kubectl --context \"giantswarm-$installation\" set image -n giantswarm deployment/${app}-unique ${app}=\"$image\""
    )

    for c in ${cmds[@]} ; do
        echo "${sep}\n$ $c"
        bash -c "$c"
        local ret=$?
        [ $ret -ne 0 ] && return $ret
    done

    echo
    echo $sep
    echo "installation:  $installation"
    echo "image:         $image"
)}

function sra() {
    local ns="default"
    while getopts ":n:" opt; do
        case ${opt} in
            n )
                ns=$OPTARG ;;
            \? )
                echo "Invalid option: -$OPTARG" 1>&2 && return 2 ;;
            : )
                echo "Invalid option: -$OPTARG requires an argument" 1>&2 && return 2 ;;
        esac
    done
    shift $((OPTIND -1))

    local s=$1
    [ -z $s ] && echo 1>&2 "Invalid: requires single argument" && return 2

    stern \
        --template '{{ .Message }}{{ "\n" }}{{.Namespace}}/{{ .PodName }}/{{ .ContainerName }}{{ "\n" }}' \
        --tail 100 \
        -n $ns \
        $s \
        | luigi -f '!cal,ver'
}

function vault-decrypt() {
        echo ===================================================================;echo
        echo $1 | xxd -r -p | keybase pgp decrypt
        echo;echo
        echo ===================================================================
}

function vault-decrypt2() {
        echo ====================================================================;echo
        echo $1 | base64 -d | keybase pgp decrypt
        echo;echo
        echo ====================================================================
}
