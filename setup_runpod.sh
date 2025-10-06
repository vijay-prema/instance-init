#!/bin/bash

# Usual steps:
# 1. Create runpod with default options and image: runpod/pytorch:1.0.1-cu1281-torch280-ubuntu2404
# 2. Open VS Code remote window, ssh using the runpd IP address/port option
# 3. Create or clone the code repo you want into /workspaces/
# 4. Download and run this init script, in the cloned directory which should be already opened in vscode:
#    `curl -sSL https://raw.githubusercontent.com/vijay-prema/instance-init/refs/heads/main/setup_runpod.sh | bash`

# Assuming the machine already has NVIDIA and CUDA installed, enough to run pytorch

# Install all the useful stuff on a fresh pod:

# update and install the basics
apt update
apt -y upgrade
apt -y install micro rsync ffmpeg fish git nvtop ncdu zip

# croc (a tool for securely sending files between machines)
if ! which -s croc; then
  curl https://getcroc.schollz.com | bash
fi

# just (a more modern make tool for running scripts in justfile)
if ! which -s just; then
  curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /bin
fi

# uv (a better python package manager)
if ! which -s uv; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  source $HOME/.local/bin/env
fi


## OPTIONAL initial setup for the python project, if a justfile, pyproject.toml or requirements.txt exists in current directory
if test -x justfile; then
  just init
elif test -f pyproject.toml && ! test -f .venv; then
  uv venv
  uv sync
  echo
  echo "Installed environment using `uv sync` and `pyproject.toml`"
  echo "Use `uv sync` after adding to `pyproject.toml`, instead of `pip install`"
  echo "Activate with: source .venv/bin/activate"
  echo
elif test -f requirements.txt && ! test -f .venv; then
  uv venv
  uv pip install -r requirements.txt
  echo
  echo "Installed environment using `uv pip` and `requirements.txt`"
  echo "Use `uv pip install`, instead of `pip install`"
  echo "Activate with: source .venv/bin/activate"
  echo
fi