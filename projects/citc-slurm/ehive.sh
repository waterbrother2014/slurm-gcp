#!/usr/bin/env bash

# https://ensembl-hive.readthedocs.io/en/version-2.5/quickstart/install.html#ehive-installation-setup
# https://ensembl-hive.readthedocs.io/en/version-2.5/contrib/alternative_meadows.html#other-job-schedulers
# https://github.com/tweep/ensembl-hive-slurm

APP_DIR='/apps'
LOG='/tmp/ehive.log'

# The following needs Slurm controller properly configured. One sure sign is slurmsync.pid is generated.
while [ ! -f /tmp/slurmsync.pid ]; do sleep 1; done

# Prerequisites
yum install -y cpan graphviz gnuplot >>${LOG} 2>&1
cpan App::cpanminus <<EOF >>${LOG} 2>&1
yes
local::lib
yes
yes
EOF

# Slurm Meadow
cd "${APP_DIR}" && git clone https://github.com/tweep/ensembl-hive-slurm.git >>${LOG} 2>&1

# Main repository
cd "${APP_DIR}" && git clone https://github.com/Ensembl/ensembl-hive.git >>${LOG} 2>&1
