#!/bin/sh
MYDIR="$( cd "$(dirname "$0")" ; pwd -P )"
function usage() {
    echo "usage: $(basename $0) [-p/--playbook -g/--guide -c/--count usercount -n/--namespace infra-namespace -m/--monitoring -e/--etherpad -w/--workspaces -s/--serverless -l/--launcher]"
}

# Defaults
PLAYBOOK=provision.yml
GUIDE_NAME=_cloud-native-workshop.yml
USER_COUNT=10
INFRA_NAMESPACE="lab-infra"
MONITORING_NAMESPACE="lab-monitoring"
ETHERPAD_NAMESPACE="lab-etherpad"
WORKSPACES_NAMESPACE="lab-workspaces"
SERVERLESS_NAMESPACE="lab-serverless"
LAUNCHER_NAMESPACE="lab-launcher"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -p|--playbook)
    PLAYBOOK="$2"
    shift # past argument
    shift # past value
    ;;
    -g|--guide)
    GUIDE_NAME="$2"
    shift # past argument
    shift # past value
    ;;
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
    -m|--monitoring)
    MONITORING_NAMESPACE="$2"
    shift # past argument
    shift # past value
    ;;
    -e|--etherpad)
    ETHERPAD_NAMESPACE="$2"
    shift # past argument
    shift # past value
    ;;
    -w|--workspaces)
    WORKSPACES_NAMESPACE="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--serverless)
    SERVERLESS_NAMESPACE="$2"
    shift # past argument
    shift # past value
    ;;
    -l|--launcher)
    LAUNCHER_NAMESPACE="$2"
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

ansible-playbook -vvv playbooks/${PLAYBOOK} \
    -e infra_namespace=${INFRA_NAMESPACE} \
    -e monitoring_namespace=${MONITORING_NAMESPACE} \
    -e etherpad_namespace=${ETHERPAD_NAMESPACE} \
    -e workspaces_namespace=${WORKSPACES_NAMESPACE} \
    -e serverless_namespace=${SERVERLESS_NAMESPACE} \
    -e launcher_namespace=${LAUNCHER_NAMESPACE} \
    -e openshift_token=$(oc whoami -t) \
    -e openshift_master_url=$(oc whoami --show-server) \
    -e openshift_user_password='openshift' \
    -e labs_project_suffix='-XX' \
    -e labs_github_account=redhat-developer-adoption-emea \
    -e labs_github_repo=cloud-native-guides \
    -e labs_github_ref=ocp-3.10 \
    -e labs_guide_name=${GUIDE_NAME} \
    -e gogs_dev_user=developer \
    -e gogs_pwd=openshift \
    -e infrasvcs_adm_user=adminuser \
    -e infrasvcs_adm_pwd=adminpwd