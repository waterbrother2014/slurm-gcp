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

"${DIR}/config.sh"
