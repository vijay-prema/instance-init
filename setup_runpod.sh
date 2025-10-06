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
if which! -s croc; then
  curl https://getcroc.schollz.com | bash
fi

# just (a more modern make tool for running scripts in justfile)
if which! -s just; then
  curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /bin
fi

# uv (a better python package manager)
if which! -s uv; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  source $HOME/.local/bin/env
fi

# run the init script, if it exists
if test -x justfile
  just init
elif test -f requirements.txt && test! -f env; then
  # otherwise if requirementes.txt exists and the env does not exist, create it and install
  uv create env
  uv install --no-color --save -r requirements.txt
fi