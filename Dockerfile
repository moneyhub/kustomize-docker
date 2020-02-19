FROM alpine:3.8
ENV KUSTOMIZE_VER 3.5.4
ENV KUBECTL_VER 1.17.3
# Versions: https://pypi.python.org/pypi/awscli#downloads
ENV AWS_CLI_VERSION 1.17.5

RUN apk --no-cache update && \
    apk --no-cache add ca-certificates groff less py-pip git make && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/*

RUN apk --no-cache add curl gettext

RUN mkdir /working
WORKDIR /working

RUN curl -L https://github.com/mozilla/sops/releases/download/v3.5.0/sops-v3.5.0.linux -o /usr/local/bin/sops \
    && chmod +x /usr/local/bin/kustomize

RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.5.4/kustomize_v3.5.4_linux_amd64.tar.gz | tar xvz -C /usr/local/bin \
    && chmod +x /usr/local/bin/kustomize

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

CMD ["/usr/local/bin/kustomize"]
