#!/usr/bin/env bash

# https://cloud.google.com/blog/products/compute/hpc-made-easy-announcing-new-features-for-slurm-on-gcp
# https://github.com/waterbrother2014/slurm-gcp
# https://github.com/schedmd/slurm
# https://www.schedmd.com/downloads.php

PROJECT='citc-slurm'
CLUSTER_NAME='g2'
ZONE='europe-west2-a'

## DIR where the current script resides
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Wait for IAP gets configured
status=1
until [ $status -eq 0 ]; do
  sleep 1
  gcloud compute ssh "${CLUSTER_NAME}-controller" --project=${PROJECT} --zone=${ZONE} --command="hostname"
  status=$?
  echo "Status: $status"
done

# Configure controller
gcloud compute scp --project=${PROJECT} --zone=${ZONE} "${DIR}/ehive.sh" "${DIR}/ehivedepn.sh" "${CLUSTER_NAME}-controller:/tmp"
gcloud compute ssh "${CLUSTER_NAME}-controller" --project=${PROJECT} --zone=${ZONE} --command="sudo /tmp/ehive.sh"
gcloud compute ssh "${CLUSTER_NAME}-controller" --project=${PROJECT} --zone=${ZONE} --command="sudo /tmp/ehivedepn.sh"

# Configure login
gcloud compute scp --project=${PROJECT} --zone=${ZONE} "${DIR}/ehive-slurm.sh" "${CLUSTER_NAME}-login0:/tmp"
gcloud compute ssh "${CLUSTER_NAME}-login0" --project=${PROJECT} --zone=${ZONE} --command="sudo chown root:root /tmp/ehive-slurm.sh; sudo mv /tmp/ehive-slurm.sh /etc/profile.d"
