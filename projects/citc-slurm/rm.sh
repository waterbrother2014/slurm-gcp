#!/usr/bin/env bash

# https://cloud.google.com/blog/products/compute/hpc-made-easy-announcing-new-features-for-slurm-on-gcp
# https://github.com/waterbrother2014/slurm-gcp
# https://github.com/schedmd/slurm
# https://www.schedmd.com/downloads.php

PROJECT='citc-slurm'

gcloud deployment-manager --project=${PROJECT} deployments delete slurm2
