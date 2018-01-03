#!/usr/bin/env bash

onduty() {
    local token='/keybase/private/kopiczko/token/slack'
    if [[ ! -f $token ]]; then
        echo "ERROR file \"$token\" does not exist" >&2
        return 1
    fi

    docker run --rm -ti -e SLACK_TOKEN=$(cat /keybase/private/kopiczko/token/slack) giantswarm/slackutil join --include "support.*" 
    docker run --rm -ti -e SLACK_TOKEN=$(cat /keybase/private/kopiczko/token/slack) giantswarm/slackutil join --include "project.*"
    docker run --rm -ti -e SLACK_TOKEN=$(cat /keybase/private/kopiczko/token/slack) giantswarm/slackutil unmute --include "support.*" 
    docker run --rm -ti -e SLACK_TOKEN=$(cat /keybase/private/kopiczko/token/slack) giantswarm/slackutil unmute --include "project.*"
    docker run --rm -ti -e SLACK_TOKEN=$(cat /keybase/private/kopiczko/token/slack) giantswarm/slackutil star --include "support.*" 
}

dutyend() {
    docker run --rm -ti -e SLACK_TOKEN=$(cat /keybase/private/kopiczko/token/slack) giantswarm/slackutil unstar --include "support.*" 
    docker run --rm -ti -e SLACK_TOKEN=$(cat /keybase/private/kopiczko/token/slack) giantswarm/slackutil mute --include "support.*" 
    docker run --rm -ti -e SLACK_TOKEN=$(cat /keybase/private/kopiczko/token/slack) giantswarm/slackutil mute --include "project.*"
} 
