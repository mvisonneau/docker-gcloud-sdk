# docker-gcloud-sdk

This is a basic docker image containing `docker`, base `gcloud-sdk` binaries as well as `kubectl`.
As of today, the main use of this container for me is to be able to perform docker-in-docker based CI jobs that can push docker images onto GCR and deploy GKE stacks.
