#!/bin/bash

source ../envs/.env

kubectl create secret generic convex-secrets \
  --from-literal=INSTANCE_NAME="${INSTANCE_NAME}" \
  --from-literal=INSTANCE_SECRET="${INSTANCE_SECRET}"
