#!/bin/sh
set -euo pipefail

# Upgrade commands moved to local docker-compose.yaml to avoid auto upgrades in hospital environments

exec "$@"
