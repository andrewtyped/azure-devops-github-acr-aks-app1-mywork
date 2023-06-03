#!/bin/bash

# Modify for your environment.
# ACR_NAME: The name of your Azure Container Registry
# SERVICE_PRINCIPAL_NAME: Must be unique within your AD tenant
#ACR_NAME=<container-registry-name>
$ACR_NAME = 'aksdevopsacr1141'
$SERVICE_PRINCIPAL_NAME = 'acr-ado-demo-1143'

# Obtain the full registry ID for subsequent command args
$ACR_REGISTRY_ID = (az acr show --name "$ACR_NAME" --query id --output tsv)

# Create the service principal with rights scoped to the registry.
# Default permissions are for docker pull access. Modify the '--role'
# argument value as desired:
# acrpull:     pull only
# acrpush:     push and pull
# owner:       push, pull, and assign roles
$SP_ID = (az ad sp create-for-rbac --name "http://$SERVICE_PRINCIPAL_NAME" --scopes "$ACR_REGISTRY_ID" --role acrpush)

$SP_ID