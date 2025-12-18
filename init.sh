#!/bin/bash
set -e

REPO_DIR="/repo"
TARGETS_DIR="$REPO_DIR/targets"

# Create targets directory and sample file
mkdir -p "$TARGETS_DIR"

cd "$REPO_DIR"

if [ -f "$REPO_DIR/repository/root.json" ]; then
  echo "==> TUF repository already initialized, skipping"
  tuf root-keys
  exit
else
  echo "==> Initializing empty TUF repository"
  tuf init
fi

tuf gen-key root
tuf gen-key targets
tuf gen-key snapshot
tuf gen-key timestamp

# Generate snapshot and timestamp metadata
tuf add
tuf snapshot
tuf timestamp

# Commit final repository
tuf commit

echo "==> Repository initialized successfully!"

tuf root-keys
