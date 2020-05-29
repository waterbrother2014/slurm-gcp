#!/usr/bin/env bash

# https://cloud.google.com/blog/products/compute/hpc-made-easy-announcing-new-features-for-slurm-on-gcp
# https://github.com/waterbrother2014/slurm-gcp
# https://github.com/schedmd/slurm
# https://www.schedmd.com/downloads.php

PROJECT='citc-slurm'
CONFIG='slurm-cluster.yaml'

## DIR where the current script resides
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
CONFIG=${DIR}/${CONFIG}

gcloud deployment-manager deployments --project=${PROJECT} create slurm --config "${CONFIG}"

CLUSTER_NAME='g1'
ZONE='europe-west4-a'

# Wait for IAP gets configured
status=1
until [ $status -eq 0 ]; do
  sleep 1
  gcloud compute ssh ${CLUSTER_NAME}-controller --project=${PROJECT} --zone=${ZONE} --command="hostname"
  status=$?
  echo "Status: $status"
done
gcloud compute scp --project=${PROJECT} --zone=${ZONE} "${DIR}/ehive.sh" "${DIR}/ehivedepn.sh" ${CLUSTER_NAME}-controller:/tmp
gcloud compute ssh ${CLUSTER_NAME}-controller --project=${PROJECT} --zone=${ZONE} --command="sudo /tmp/ehive.sh"
gcloud compute ssh ${CLUSTER_NAME}-controller --project=${PROJECT} --zone=${ZONE} --command="sudo /tmp/ehivedepn.sh"
