FROM registry.redhat.io/ubi8/ubi-minimal

COPY content_sets_epel7.repo /etc/yum.repos.d/

ENV OC_CLI_VERSION 4.1.14

RUN microdnf install -y bash git gzip tar findutils jq python3-six python3-pip rsync openssh-clients

RUN /usr/bin/pip3.6 install ansible jmespath openshift

RUN microdnf -y clean all && rm -rf /var/cache/yum && echo "Installed Packages" && rpm -qa | sort -V && echo "End Of Installed Packages" && \
    # install yq (depends on jq and pyyaml - if jq and pyyaml not already installed, this will try to compile it)
    /usr/bin/pip3.6 install --user yq && \
    # could be installed in /opt/app-root/src/.local/bin or /root/.local/bin
    for d in /opt/app-root/src/.local /root/.local; do \
      if [[ -d ${d} ]]; then \
        cp ${d}/bin/yq /usr/local/bin/; \
        pushd ${d}/lib/python3.6/site-packages/ >/dev/null; \
          cp -r PyYAML* xmltodict* yaml* yq* /usr/lib/python3.6/site-packages/; \
        popd >/dev/null; \
      fi; \
    done && \
    chmod +x /usr/local/bin/yq && \
    ln -s /usr/bin/python3.6 /usr/bin/python

WORKDIR /tmp

RUN curl -OL https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_CLI_VERSION}/openshift-client-linux-${OC_CLI_VERSION}.tar.gz && \
    tar xvzf openshift-client-linux-${OC_CLI_VERSION}.tar.gz -C /usr/local/bin oc && \
    rm openshift-client-linux-${OC_CLI_VERSION}.tar.gz

RUN mkdir -p /usr/share/ansible/openshift \
             /etc/ansible /opt/workshop /opt/ansible \
             ${BASE_DIR}/{etc,.kube,.ansible/tmp}

WORKDIR /opt/workshop

ENV ANSIBLE_LOCAL_TEMP=/opt/workshop/.ansible/tmp ANSIBLE_CONFIG=/opt/workshop/ansible.cfg
COPY setup/ /opt/workshop
#COPY setup/playbooks /opt/workshop/project
#ADD setup/requirements.yml /opt/workshop/project/requirements.yml
#RUN ansible-galaxy install -r /opt/workshop/requirements.yml -f
RUN printf "[defaults]\nremote_tmp = ${ANSIBLE_LOCAL_TEMP}" > ansible.cfg
RUN chmod -R g=u /opt/{ansible,workshop}
RUN chmod a+x /opt/workshop/*.sh






