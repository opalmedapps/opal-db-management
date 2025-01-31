#!/bin/sh
# option pipefail available on alpine sh
# shellcheck disable=SC3040
set -euo pipefail

# Upgrade commands moved to local docker-compose.yaml to avoid auto upgrades in hospital environments

exec "$@"
