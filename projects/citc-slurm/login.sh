#!/usr/bin/env bash

PROJECT='citc-slurm'
ZONE='europe-west1-d'
CLUSTER_NAME='g2'

gcloud compute --project=${PROJECT} ssh --zone=${ZONE} ${CLUSTER_NAME}-login0
