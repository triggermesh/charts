FROM gcr.io/triggermesh/helm

# Until the base image is upgraded to >2.9, solving Istio CRDs timing issue
ENV VERSION=v2.11.0
RUN set -e; \
  curl -o helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz; \
  echo "02a4751586d6a80f6848b58e7f6bd6c973ffffadc52b4c06652db7def02773a1  helm.tar.gz" | sha256sum -c -; \
  tar -zxvf helm.tar.gz; \
  mv linux-amd64/helm /builder/helm/helm; \
  rm -rf helm.tar.gz linux-amd64
# End temp upgrade

RUN helm init --client-only

# found no support for file:// protocol
#COPY repo /repo
COPY knative /charts/knative

WORKDIR /charts

COPY installer/*.sh ./

ENTRYPOINT ["./install-knative.sh"]
