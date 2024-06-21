FROM alpine:3.17

ENV SOPS_VER 3.8.1
ENV KUSTOMIZE_VER 5.2.1
ENV KUBECTL_VER 1.23.17
# Versions: https://pypi.python.org/pypi/awscli#downloads
ENV AWS_CLI_VERSION 1.29.82

RUN apk --no-cache add curl gettext bash ca-certificates groff less \
    py-pip git make curl gettext jq
RUN pip --no-cache-dir install awscli==${AWS_CLI_VERSION} yq

RUN mkdir /working
WORKDIR /working

RUN curl -L https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v${SOPS_VER}.linux -o /usr/local/bin/sops \
    && chmod +x /usr/local/bin/sops

RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VER}/kustomize_v${KUSTOMIZE_VER}_linux_amd64.tar.gz | tar xvz -C /usr/local/bin \
    && chmod +x /usr/local/bin/kustomize

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

CMD ["/usr/local/bin/kustomize"]
