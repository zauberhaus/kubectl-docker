#!/bin/sh

KUBECTL_VERSION="$1"

case `arch` in
x86_64)
    TARGETPLATFORM=amd64
    ;;
aarch64)
    TARGETPLATFORM=arm64
    ;;
esac  

if [ -z "$TARGETPLATFORM"] ; then
echo "Unknown arch: `arch`"
exit 1
fi   

curl -LOs https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${TARGETPLATFORM}/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl