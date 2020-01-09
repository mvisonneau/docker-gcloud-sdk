FROM docker:19.03.5

ENV GOOGLE_SDK_VERSION 275.0.0
ENV YAMLLINT_VERSION 1.11.1

ENV PATH "$PATH:/opt/google-cloud-sdk/bin/"

ADD https://storage.googleapis.com/kubernetes-release/release/v1.16.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN \
chmod +x /usr/local/bin/kubectl ;\
apk --no-cache add make git wget openssl python py-pip bash gettext jq ca-certificates gettext \
&& wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_SDK_VERSION}-linux-x86_64.tar.gz -O /tmp/sdk.tar.gz \
&& tar zxvf /tmp/sdk.tar.gz -C /opt \
&& /opt/google-cloud-sdk/install.sh --usage-reporting=false --path-update=true \
&& gcloud --quiet components update \
&& pip install -Iv --upgrade \
     pip \
     yamllint==${YAMLLINT_VERSION} \
&& apk del py-pip \
&& rm -f /tmp/sdk.tar.gz

ENTRYPOINT []
