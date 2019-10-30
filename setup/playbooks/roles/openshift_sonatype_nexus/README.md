Ansible Role: Sonatype Nexus on OpenShift
[![Build Status](https://travis-ci.org/siamaksade/ansible-openshift-nexus.svg?branch=master)](https://travis-ci.org/siamaksade/ansible-openshift-nexus)
=========

Ansible Role for deploying Sonatype Nexus 3 on OpenShift with Red Hat enterprise maven repositories preconfigured on Nexus

NOTE: This role has been updated to only support Sonatype Nexus 3


Role Variables
------------

|Variable               | Default Value            | Description   |
|-----------------------|--------------------------|---------------|
|`nexus_service_name`          | nexus                    | Nexus service name on OpenShift  |
|`nexus_image_version`         | 3.12.1                   | Nexus image version as available on Docker Hub for [Nexus 3](https://hub.docker.com/r/sonatype/nexus3/tags) |
|`nexus_volume_capacity`       | 10Gi                     | Persistent volume capacity for Nexus  |
|`nexus_max_memory`            | 2Gi                      | Max memory allocated to Nexus container |
|`nexus_min_memory`            | 512Mi                    | Min memory allocated to Nexus container |
|`nexus_max_cpu`               | 1                        | Max cpu allocated to Nexus container |
|`nexus_min_cpu`               | 200m                     | Min cpu allocated to Nexus container |
|`nexus_admin_user`            | adminuser                | Nexus admin user |
|`nexus_admin_password`        | admin123                 | Nexus admin password |
|`current_nexus_admin_password`| admin123                 | Admin password for current instance (if an existing instance needs reconfiguration) |
|`project_name`                | nexus                    | OpenShift project name for the Nexus container  |
|`project_display_name`        | Nexus                    | OpenShift project display name for the Nexus container  |
|`project_desc`                | Nexus Repository Manager | OpenShift project description for the Nexus container |
|`project_annotations`         | -                        | OpenShift project annotations for the Nexus container |
|`openshift_cli`               | oc                       | OpenShift CLI command and arguments (e.g. auth)       | 


Example Playbook
------------

```
name: Example Playbook
hosts: localhost
tasks:
- import_role:
    name: siamaksade.openshift_nexus
  vars:
    project_name: "cicd-project"
    openshift_cli: "oc --server http://master:8443"
```