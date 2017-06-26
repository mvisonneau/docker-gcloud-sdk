FROM docker:latest

ENV GCLOUD_PATH_PREFIX '/opt'
ENV GCLOUD_SDK_FILE 'google-cloud-sdk-160.0.0-linux-x86_64.tar.gz'

RUN \
mkdir -p /opt ;\
apk add --no-cache openssl python bash ;\
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${GCLOUD_SDK_FILE} -O ${GCLOUD_PATH_PREFIX}/${GCLOUD_SDK_FILE} ;\
tar zxvf /opt/${GCLOUD_SDK_FILE} -C /opt ;\
rm -f /opt/${GCLOUD_SDK_FILE} ;\
${GCLOUD_PATH_PREFIX}/google-cloud-sdk/install.sh --path-update true -q

ENTRYPOINT []
