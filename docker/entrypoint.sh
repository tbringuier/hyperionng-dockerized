#!/bin/sh
set -e

USERDATA_DIR="${HYPERION_USERDATA_DIR:-/config}"
mkdir -p "$USERDATA_DIR"

exec hyperiond --userdata "$USERDATA_DIR"