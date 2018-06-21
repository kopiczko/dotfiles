FROM alpine

RUN apk add --update \
  py-pip \
  jq \
  && pip install yq \
  && rm /var/cache/apk/*

ENTRYPOINT ["/usr/bin/yq"]

# ex: ft=dockerfile
