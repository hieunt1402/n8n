#!/usr/bin/env bash

echo "[INFO] Starting ..."

set -e

# Load environment variables from .env file if exists
if [ -f "/.env" ]; then
    echo "[INFO] Loading environment variables from /.env"
    export $(grep -v '^#' /.env | xargs)
else
    echo "[WARN] No .env file found. Using default environment variables."
fi

# Start n8n as PID 1
echo "[INFO] Starting n8n..."
exec n8n
