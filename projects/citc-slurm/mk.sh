#!/usr/bin/env bash

# https://cloud.google.com/blog/products/compute/hpc-made-easy-announcing-new-features-for-slurm-on-gcp
# https://github.com/waterbrother2014/slurm-gcp
# https://github.com/schedmd/slurm
# https://www.schedmd.com/downloads.php

PROJECT='citc-slurm'
CONFIG='slurm-cluster.yaml'

## DIR where the current script resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CONFIG=${DIR}/${CONFIG}

gcloud deployment-manager deployments --project=${PROJECT} create slurm --config "${CONFIG}"

# Wait for IAP gets configured
sleep 10
CLUSTER_NAME='g1'
ZONE='europe-west4-a'

gcloud compute scp --project=${PROJECT} --zone=${ZONE} "${DIR}/ehive.sh" ${CLUSTER_NAME}-controller:/tmp
gcloud compute ssh ${CLUSTER_NAME}-controller --project=${PROJECT} --zone=${ZONE} --command="sudo /tmp/ehive.sh &"