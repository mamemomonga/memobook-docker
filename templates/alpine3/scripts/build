#!/bin/bash
set -euo pipefail
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
source $BASEDIR/config.env

exec docker build -t $DCIMG $BASEDIR
