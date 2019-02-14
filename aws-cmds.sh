#!/bin/bash

set -e

step() {
  echo ""
  echo "  ****************************************"
  echo "  >>>> $1"
  echo "  ****************************************"
  echo ""
}

fail() {
  printf "Error: $1 \n\n"
  usage
  exit 1
}

command() {
  echo "SHELL: $1"
  eval $1
}
step "Create vmimport-role"
aws iam create-role --role-name vmimport --assume-role-policy-document file://role_templates/trust-policy.json

step "assign vmimport-role"
aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document file://role_templates/role-policy.json
