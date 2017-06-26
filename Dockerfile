FROM docker:latest

ENV GCLOUD_PATH '/opt'
ENV GCLOUD_SDK_FILE 'google-cloud-sdk-160.0.0-linux-x86_64.tar.gz'

RUN \
apk add --no-cache openssl python ;\
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${GCLOUD_SDK_FILE} -O ${GCLOUD_PATH}/${GCLOUD_SDK_FILE} ;\
tar zxvf /opt/${GCLOUD_SDK_FILE} -C /opt ;\
rm -f /opt/${GCLOUD_SDK_FILE} ;\
${GCLOUD_PATH}/google-cloud-sdk/install.sh --path-update true --rc-path /etc/profile -q

ENTRYPOINT []
