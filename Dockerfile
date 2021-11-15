FROM alpine:latest as builder

ARG KUBECTL_VERSION=v1.22.3
COPY download.sh /usr/local/bin/download.sh

RUN apk update && apk add \
    curl \
    ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/* && \
    /usr/local/bin/download.sh "${KUBECTL_VERSION}"

FROM alpine:latest 

RUN apk update && apk add \
   busybox-extras \
   net-tools \
   jq \
   ca-certificates && \
   update-ca-certificates && \
   rm -rf /var/cache/apk/*

RUN adduser -D -u 1000 user 

COPY --from=builder --chown=1000:1000 /usr/local/bin/kubectl /usr/local/bin/kubectl

