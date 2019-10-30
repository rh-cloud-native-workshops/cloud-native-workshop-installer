#!/bin/sh

TOKEN=$(oc whoami -t | base64)

NAMESPACE="cnw-installer"

if [ -z "${TOKEN}" ]
then
    echo "You have to log in in your OCP cluster ;-)"
    exit 1
fi

oc new-project ${NAMESPACE}

oc delete secret cnw-token-secret -n ${NAMESPACE}

cat ./cnw-token-secret.yaml | \
  sed "s/{{\b*NAMESPACE\b*}}/$(echo -n ${NAMESPACE} | base64)/" | \
  sed "s/{{\b*TOKEN\b*}}/${TOKEN}/" | oc create -n ${NAMESPACE} -f -

oc delete job cnw-installer-batch -n ${NAMESPACE} ;  oc apply -n ${NAMESPACE} -f ./cnw-installer-batch.yaml