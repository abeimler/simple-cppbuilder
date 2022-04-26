#!/bin/env bash

set -euo pipefail

source $SETUP_ENV_SCRIPT
source /custom-env.sh

exec "$@"