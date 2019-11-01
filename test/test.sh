#!/bin/bash

# Docker exit codes:
# SIGTERM: 143
# SIGKILL: 137

exit_code=$(docker ps -a | grep $1 | awk '{ print $9 }')
if [ "$exit_code" != "(143)" ]; then
  echo "Tests failed!"
  docker rm $1
  exit 1
else
  echo "Tests passed!"
  docker rm $1
  exit 0
fi
