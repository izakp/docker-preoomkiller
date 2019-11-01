#!/bin/bash

export PREOOMKILLER_POLL_INTERNAL=1
export PREOOMKILLER_MEMORY_USE_FACTOR=0.5
export PREOOMKILLER_DEBUG=1

exec /usr/local/bin/preoomkiller &

python test.py
