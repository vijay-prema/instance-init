#!/bin/bash

# Usual steps:
# 1. Create runpod with default options and image: runpod/pytorch:1.0.1-cu1281-torch280-ubuntu2404
# 2. Open VS Code remote window, ssh using the runpd IP address/port option
# 3. Create or clone the code repo you want into /workspaces/
# 4. Download and run this init script:
#    `curl -sSL https://raw.githubusercontent.com/vijay-prema/instance-init/refs/heads/main/setup_runpod.sh | bash`

# Assuming the machine already has NVIDIA and CUDA installed, enough to run pytorch

# Install all the useful stuff on a fresh pod:

# update and install the basics
apt update
apt -y upgrade
apt -y install micro rsync ffmpeg fish git nvtop ncdu zip

# croc (a tool for securely sending files between machines
curl https://getcroc.schollz.com | bash

# just (a more modern make tool for running scripts in justfile)
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /bin

# uv (a better python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env

# run the init script to set up the python env and install necessary packages
just init
