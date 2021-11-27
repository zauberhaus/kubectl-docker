#!/bin/sh

KUBECTL_VERSION=$1

[ -z "$KUBECTL_VERSION" ] && KUBECTL_VERSION=`wget -q -O - https://dl.k8s.io/release/stable.txt`

case `arch` in
x86_64)
    TARGETPLATFORM=amd64
    ;;
aarch64)
    TARGETPLATFORM=arm64
    ;;
esac  

if [ -z "$TARGETPLATFORM" ] ; then
echo "Unknown arch: `arch`"
exit 1
fi   

URL="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETPLATFORM}/kubectl"

echo "Download $URL"

wget $URL \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin/kubectl

URL="https://github.com/jetstack/cert-manager/releases/latest/download/kubectl-cert_manager-linux-${TARGETPLATFORM}.tar.gz" 
wget -O kubectl-cert-manager.tar.gz $URL \
  && tar xvzf kubectl-cert-manager.tar.gz \
  && chmod +x kubectl-cert_manager \
  && mv kubectl-cert_manager /usr/local/bin \
  && rm -rf kubectl-cert_manager \
  && rm kubectl-cert-manager.tar.gz