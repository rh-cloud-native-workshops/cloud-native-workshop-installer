#!/bin/sh
#sudo pip install virtualenv

virtualenv venv
source venv/bin/activate

pip install ansible jmespath openshift

export ROLES_PATH=$(pwd)/setup/playbooks/roles

export ROLES_PATH_REFRESH=$(pwd)/setup/playbooks/roles.refresh
mkdir -p ${ROLES_PATH_REFRESH}

ansible-galaxy install -p $ROLES_PATH_REFRESH -r ./setup/requirements.yml -f

ansible-galaxy install -p $ROLES_PATH_REFRESH ansible.kubernetes-modules
ansible-galaxy install -p $ROLES_PATH_REFRESH ansibleplaybookbundle.asb-modules

echo "\n>>> DIFF between existing roles ${ROLES_PATH} and refreshed roles ${ROLES_PATH_REFRESH}\n"
diff -rq ${ROLES_PATH} ${ROLES_PATH_REFRESH} -x .galaxy_install_info