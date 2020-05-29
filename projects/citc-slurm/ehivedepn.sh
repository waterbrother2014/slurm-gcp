#!/usr/bin/env bash

# https://ensembl-hive.readthedocs.io/en/version-2.5/quickstart/install.html#ehive-installation-setup
# https://ensembl-hive.readthedocs.io/en/version-2.5/contrib/alternative_meadows.html#other-job-schedulers
# https://github.com/tweep/ensembl-hive-slurm

APP_DIR='/apps'
LOG='/tmp/ehive.log'

# Wait for cpanm ready
status=1
until [ $status -eq 0 ]; do
  sleep 1
  cpanm -V
  status=$?
  echo "Status: $status"
done
cd "${APP_DIR}/ensembl-hive" && cpanm --installdeps --with-recommends . >>${LOG} 2>&1

# Double-check
{
  perl -v
  mysql -V
  dot -V
  gnuplot -V
  cpanm -V
} >>${LOG} 2>&1
