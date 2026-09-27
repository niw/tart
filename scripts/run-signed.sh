#!/bin/sh

# helper script to build and run a signed tart binary
# usage: ./scripts/run-signed.sh run macos

set -e

"$(dirname "$0")/build-app.sh"

.build/tart.app/Contents/MacOS/tart "$@"
