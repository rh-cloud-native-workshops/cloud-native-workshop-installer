#!/bin/sh

TOKEN=$(oc whoami -t | base64)

NAMESPACE="cnw-installer"

if [ -z "${TOKEN}" ]
then
    echo "You have to log in in your OCP cluster ;-)"
    exit 1
fi

oc new-project ${NAMESPACE}

#oc delete secret cnw-token-secret -n ${NAMESPACE}

#cat ./cnw-token-secret.yaml | \
#  sed "s/{{\s*NAMESPACE\s*}}/$(echo -n ${NAMESPACE} | base64)/" | \
#  sed "s/{{\s*TOKEN\s*}}/${TOKEN}/" | oc create -n ${NAMESPACE} -f -

oc apply -n ${NAMESPACE} -f ./cnw-installer-role.yaml
oc apply -n ${NAMESPACE} -f ./cnw-installer-service-account.yaml

cat ./cnw-installer-role-binding.yaml | \
  sed "s/{{\s*NAMESPACE\s*}}/${NAMESPACE}/" | oc apply -n ${NAMESPACE} -f -

oc delete job cnw-installer -n ${NAMESPACE} ;  oc apply -n ${NAMESPACE} -f ./cnw-installer-batch.yaml