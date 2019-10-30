#!/bin/sh
MYDIR="$( cd "$(dirname "$0")" ; pwd -P )"
function usage() {
    echo "usage: $(basename $0) [-c/--count usercount] -n/--namespace infra-namespace"
}

# Defaults
USER_COUNT=10
INFRA_NAMESPACE="lab-infra"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -c|--count)
    USER_COUNT="$2"
    shift # past argument
    shift # past value
    ;;
    -n|--namespace)
    INFRA_NAMESPACE="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    echo "Unknown option: $key"
    usage
    exit 1
    ;;
esac
done

oc new-project ${INFRA_NAMESPACE}

#export ROLES_PATH=$(pwd)/roles
#printf "[defaults]\nroles_path = ${ROLES_PATH}" > ansible.cfg
#export ANSIBLE_CONFIG=./ansible.cfg

ansible-playbook -vvv playbooks/provision.yml \
    -e namespace=${INFRA_NAMESPACE} \
    -e openshift_token=$(oc whoami -t) \
    -e openshift_master_url=$(oc whoami --show-server) \
    -e openshift_user_password='openshift' \
    -e project_suffix='-XX' \
    -e github_account=redhat-developer-adoption-emea \
    -e github_ref=ocp-3.10 \
    -e guide_name=maven \
    -e gogs_dev_user=developer \
    -e gogs_pwd=openshift \
    -e infrasvcs_adm_user=adminuser \
    -e infrasvcs_adm_pwd=adminpwd