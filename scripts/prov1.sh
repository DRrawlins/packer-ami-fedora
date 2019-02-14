#!/bin/bash
set -o pipefail
set -x
set -e

echo "+) Updating system packages"
dnf makecache

# This will eventually cause packer to hang up and skip this provisioner. We re-run this via packer_sucks_pt2.sh
dnf update -y
