FROM docker:latest

ENV GCLOUD_PATH_PREFIX '/opt'
ENV GCLOUD_SDK_FILE 'google-cloud-sdk-162.0.1-linux-x86_64.tar.gz'

ADD https://storage.googleapis.com/kubernetes-release/release/v1.6.7/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN \
chmod +x /usr/local/bin/kubectl ;\
mkdir -p /opt ;\
echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/edge" >> /etc/apk/repositories ;\
apk add --no-cache openssl python bash gettext ;\
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${GCLOUD_SDK_FILE} -O ${GCLOUD_PATH_PREFIX}/${GCLOUD_SDK_FILE} ;\
tar zxvf /opt/${GCLOUD_SDK_FILE} -C /opt ;\
rm -f /opt/${GCLOUD_SDK_FILE} ;\
${GCLOUD_PATH_PREFIX}/google-cloud-sdk/install.sh --path-update false -q ;\
for i in $(find ${GCLOUD_PATH_PREFIX}/google-cloud-sdk/bin -type f -maxdepth 1); do echo $i; ln -s $i /usr/local/bin/$(basename $i); done

ENTRYPOINT []
