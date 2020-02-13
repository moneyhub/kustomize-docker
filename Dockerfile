FROM alpine:3.8
ENV KUSTOMIZE_VER 3.5.4
ENV KUBECTL_VER 1.17.3
# Versions: https://pypi.python.org/pypi/awscli#downloads
ENV AWS_CLI_VERSION 1.17.5

RUN apk --no-cache update && \
    apk --no-cache add ca-certificates groff less py-pip && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/*

RUN apk --no-cache add curl gettext

RUN mkdir /working
WORKDIR /working

RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VER}/kustomize_${KUSTOMIZE_VER}_linux_amd64  -o /usr/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

CMD ["/usr/local/bin/kustomize"]
