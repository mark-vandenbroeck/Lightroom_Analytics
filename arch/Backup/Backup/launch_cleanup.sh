#! /bin/bash

# Set environment
TMPDIR=/var/folders/vz/j95tvyp91bj_krhf0sly7pr80000gn/T/
XPC_FLAGS=0x0
TERM=xterm-256color
SSH_AUTH_SOCK=/private/tmp/com.apple.launchd.8ScyQeqjF0/Listeners
XPC_SERVICE_NAME=0
TERM_PROGRAM=Apple_Terminal
MallocProbGuardViaLaunchd=1
TERM_PROGRAM_VERSION=453
TERM_SESSION_ID=A6037DC7-3678-4236-8842-79BD117FD10E
SHELL=/bin/zsh
HOME=/Users/mark
LOGNAME=mark
USER=mark
PATH=/Users/mark/.nvm/versions/node/v20.15.0/bin:/opt/homebrew/bin:/Users/mark/bin:/Users/mark/opt/miniconda3/bin:/Users/mark/opt/miniconda3/condabin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
SHLVL=1
CONDA_EXE=/Users/mark/opt/miniconda3/bin/conda
_CE_M=
_CE_CONDA=
CONDA_PYTHON_EXE=/Users/mark/opt/miniconda3/bin/python
CONDA_SHLVL=1
CONDA_PREFIX=/Users/mark/opt/miniconda3
CONDA_DEFAULT_ENV=base
CONDA_PROMPT_MODIFIER=(base)
NVM_DIR=/Users/mark/.nvm
NVM_CD_FLAGS=-q
NVM_BIN=/Users/mark/.nvm/versions/node/v20.15.0/bin
NVM_INC=/Users/mark/.nvm/versions/node/v20.15.0/include/node
LC_CTYPE=UTF-8

date
cd /Users/mark/Documents/Python/Fluvius
source venv/bin/activate
cd ../Lightroom/Backup/Backup
python cleanup.py

