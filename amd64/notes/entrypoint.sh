#!/bin/bash
set -e

source /home/$USER/$PYENV/bin/activate

exec "$@"
