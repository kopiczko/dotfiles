#!/usr/bin/env bash

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

dockerfile="${dir}/install_yq.dockerfile"
tag="kopiczko/yq"

set -ex

docker build -f $dockerfile -t  $tag .
