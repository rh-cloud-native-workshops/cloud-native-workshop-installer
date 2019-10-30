Ansible Role: Sonarqube on OpenShift
[![Build Status](https://travis-ci.org/cvicens/ansible-openshift-sonarqube.svg?branch=master)](https://travis-ci.org/cvicens/ansible-openshift-sonarqube)
=========

Ansible Role for deploying Sonarqube 7 on OpenShift with Red Hat enterprise maven repositories preconfigured on Sonarqube

NOTE: This role has been updated to only support Sonarqube 7


Role Variables
------------

|Variable               | Default Value            | Description   |
|-----------------------|--------------------------|---------------|
|`sonarqube_service_name`          | sonarqube                    | Sonarqube service name on OpenShift  |
|`sonarqube_image_version`         | 7.0                   | Sonarqube image version as available on Docker Hub for [Sonarqube 7](https://hub.docker.com/r/openshiftdemos/sonarqube/tags/) |
|`sonarqube_volume_capacity`       | 1Gi                     | Persistent volume capacity for Sonarqube  |
|`sonarqube_max_memory`            | 6Gi                      | Max memory allocated to Sonarqube container |
|`sonarqube_min_memory`            | 512Mi                    | Min memory allocated to Sonarqube container |
|`sonarqube_max_cpu`               | 1                        | Max cpu allocated to Sonarqube container |
|`sonarqube_min_cpu`               | 200m                     | Min cpu allocated to Sonarqube container |
|`sonarqube_admin_user`            | adminuser                | Sonarqube admin user |
|`sonarqube_admin_password`        | admin123                 | Sonarqube admin password |
|`current_sonarqube_admin_password`| admin123                 | Admin password for current instance (if an existing instance needs reconfiguration) |
|`project_name`                | sonarqube                    | OpenShift project name for the Sonarqube container  |
|`project_display_name`        | Sonarqube                    | OpenShift project display name for the Sonarqube container  |
|`project_desc`                | Sonarqube Repository Manager | OpenShift project description for the Sonarqube container |
|`project_annotations`         | -                        | OpenShift project annotations for the Sonarqube container |
|`openshift_cli`               | oc                       | OpenShift CLI command and arguments (e.g. auth)       | 


Example Playbook
------------

```
name: Example Playbook
hosts: localhost
tasks:
- import_role:
    name: cvicens.openshift_sonarqube
  vars:
    project_name: "cicd-project"
    openshift_cli: "oc --server http://master:8443"
```