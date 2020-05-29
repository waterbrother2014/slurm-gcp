#!/usr/bin/env bash

PROJECT='citc-slurm'
ZONE='europe-west4-a'
CLUSTER_NAME='g1'

gcloud compute --project=${PROJECT} ssh --zone=${ZONE} ${CLUSTER_NAME}-login0