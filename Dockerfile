FROM jenkins/jnlp-slave:3.16-1-alpine

USER root

ENV KUBECTL_VERSION="1.9.0" \
    HELM_VERSION="2.8.2" \
    DOCKER_VERSION="17.12.0-ce" 

ENV FILENAME="helm-v${HELM_VERSION}-linux-amd64.tar.gz"

RUN apk add --update ca-certificates -t deps python3 jq git curl curl-dev bash docker curl

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl  -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME} -o /tmp/${FILENAME} \
    && tar -zxvf /tmp/${FILENAME} -C /tmp \
    && mv /tmp/linux-amd64/helm /bin/helm \
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -rf /tmp/*

USER jenkins
