#!/usr/bin/env bash

# https://ensembl-hive.readthedocs.io/en/version-2.5/quickstart/install.html#ehive-installation-setup
# https://ensembl-hive.readthedocs.io/en/version-2.5/contrib/alternative_meadows.html#other-job-schedulers
# https://github.com/tweep/ensembl-hive-slurm

APP_DIR='/apps'
LOG='/tmp/ehive.log'

echo "Starting time: $(date)" >>${LOG} 2>&1

# Wait for cpanm ready
status=1
until [ $status -eq 0 ]; do
  cpanm -V <<EOF >>${LOG} 2>&1
'\n'
EOF
  status=$?
  echo "Status: $status" >>${LOG} 2>&1
  sleep 1s
done
cd "${APP_DIR}/ensembl-hive" && cpanm --installdeps --with-recommends . <<EOF >>${LOG} 2>&1
'\n'
EOF

# Double-check
{
  perl -v
  mysql -V
  dot -V
  gnuplot -V
  cpanm -V <<EOF
'\n'
EOF
} >>${LOG} 2>&1
