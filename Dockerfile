FROM alpine:latest as builder

ARG KUBECTL_VERSION
COPY download.sh /usr/local/bin/download.sh

RUN apk update && apk add \
    ca-certificates && \
    rm -rf /var/cache/apk/* && \
    /usr/local/bin/download.sh "${KUBECTL_VERSION}"

FROM alpine:latest 

RUN apk update && apk add \
   busybox-extras \
   bash\
   net-tools \
   jq \
   ca-certificates && \
   update-ca-certificates && \
   rm -rf /var/cache/apk/*

RUN adduser -D -u 1000 user

WORKDIR /home/user

COPY --from=builder /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=builder /usr/local/bin/kubectl-cert_manager /usr/local/bin/kubectl-cert_manager

USER user
