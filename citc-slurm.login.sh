#!/usr/bin/env bash

PROJECT='citc-slurm'
ZONE='europe-west4-a'

gcloud compute --project=${PROJECT} ssh --zone=${ZONE} g1-login0