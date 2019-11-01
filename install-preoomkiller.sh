#!/bin/bash

# curl -sSf https://s3.amazonaws.com/artsy-provisioning-public/install-preoomkiller.sh | sh

set -e

loc='https://s3.amazonaws.com/artsy-provisioning-public/preoomkiller'
out='/usr/local/bin/preoomkiller'

check_cmd() {
  command -v "$1" > /dev/null 2>&1
}

if ! check_cmd curl; then
  echo "curl needs to be installed to download preoomkiller"
  exit 1
fi

if ! check_cmd python; then
  echo "python needs to be installed to run preoomkiller"
  exit 1
fi

curl --silent --show-error --fail --location "$loc" --output "$out"
chmod +x "$out"

echo 'Sucessfully installed preoomkiller'
exit 0
