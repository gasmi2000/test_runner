#!/bin/bash
set -e

if [[ -z "$GH_URL" || -z "$GH_TOKEN" ]]; then
  echo "❌ GH_URL and GH_TOKEN must be provided"
  exit 1
fi

# Defaults
RUNNER_NAME=${RUNNER_NAME:-docker-runner}
RUNNER_LABELS=${RUNNER_LABELS:-docker}

cd /actions-runner

# Register runner
./config.sh \
  --url "$GH_URL" \
  --token "$GH_TOKEN" \
  --name "$RUNNER_NAME" \
  --labels "$RUNNER_LABELS" \
  --unattended

# Deregister automatically on exit
cleanup() {
  echo "🧹 Removing runner..."
  ./config.sh remove --unattended --token "$GH_TOKEN"
}
trap cleanup EXIT

# Start runner service
./run.sh
