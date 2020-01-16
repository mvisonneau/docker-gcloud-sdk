FROM docker:19.03.5

ARG GOOGLE_SDK_VERSION 275.0.0
ARG YAMLLINT_VERSION   1.11.1
ARG KUBECTL_VERSION    v1.17.1
ARG HELM_VERSION       v3.0.2
ARG S5_VERSION         0.1.6

ENV PATH "$PATH:/opt/google-cloud-sdk/bin/"

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN \
apk --no-cache add make git wget openssl python py-pip bash gettext jq ca-certificates gettext \
&& wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_SDK_VERSION}-linux-x86_64.tar.gz -O /tmp/sdk.tar.gz \
&& tar zxvf /tmp/sdk.tar.gz -C /opt \
&& /opt/google-cloud-sdk/install.sh --usage-reporting=false --path-update=true \
&& gcloud --quiet components update \
&& pip install -Iv --upgrade \
     pip \
     yamllint==${YAMLLINT_VERSION} \
&& apk del py-pip \
&& curl -sSL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xz \
&& mv linux-amd64/helm /usr/local/bin/helm \
&& rm -rf linux-amd64 \
&& helm repo add stable https://kubernetes-charts.storage.googleapis.com \
&& helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com \
&& helm repo add mvisonneau https://charts.visonneau.fr \
&& wget https://github.com/mvisonneau/s5/releases/download/${S5_VERSION}/s5_${S5_VERSION}_linux_amd64.tar.gz -O /tmp/s5.tar.gz \
&& tar -C /usr/local/bin -zxvf /tmp/s5.tar.gz s5 \
&& chmod +x /usr/local/bin/kubectl /usr/local/bin/s5 \
&& rm -f /tmp/sdk.tar.gz

ENTRYPOINT []
