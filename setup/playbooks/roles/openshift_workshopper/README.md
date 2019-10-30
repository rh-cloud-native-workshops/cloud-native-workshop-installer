Ansible Role: Workshopper on OpenShift
[![Build Status](https://travis-ci.org/siamaksade/ansible-openshift-workshopper.svg?branch=master)](https://travis-ci.org/siamaksade/ansible-openshift-workshopper)
=========

Ansible Role for deploying [Workshopper](https://github.com/openshift-evangelists/workshopper) on OpenShift as the instruction guidebook for demos and workshops.


Role Variables
------------

| Variable                       | Default Value         | Description   |
|--------------------------------|-----------------------|---------------|
|`workshopper_name`              | `guides`              | Workshopper service name on OpenShift |
|`workshopper_image_version`     | `latest`              | Workshopper container image version on [Docker Hub](https://hub.docker.com/r/osevg/workshopper/tags/) |
|`workshopper_content_url_prefix`| `https://raw.githubusercontent.com/osevg/workshopper-content/master` | Workshop content prefix url |
|`workshopper_workshop_urls`     | `{{ workshopper_content_url_prefix }}/_workshops/training.yml`       | Comma-separated workshop urls |
|`workshopper_env_vars`          | `{}`                  | Environment variables set on the workshopper container as configuration |   
|`min_memory`                    | `128Mi`               | Memory request |   
|`max_memory`                    | `512Mi`               | Memory limit |   
|`min_cpu`                       | `0`                   | CPU request |   
|`max_cpu`                       | `0`                   | CPU limit  |   
|`project_name`                  | `workshopper`         | OpenShift project name for the workshopper container  |
|`project_display_name`          | `Workshopper`         | OpenShift project display name for the workshopper container  |
|`project_desc`                  | `Workshopper Guides`  | OpenShift project description for the workshopper container |
|`project_annotations`           | -                     | OpenShift project annotations for the workshopper container |
|`openshift_cli`                 | `oc`                  | OpenShift CLI command and arguments (e.g. auth)       | 

Example Playbook
------------

```
name: Example Playbook
hosts: localhost
tasks:
- import_role:
    name: siamaksade.openshift_workshopper
  vars:
    project_name: "cicd-project"
    workshopper_content_url_prefix: https://raw.githubusercontent.com/siamaksade/coolstore-demo-guides/openshift-3.7
    workshopper_workshop_urls: {{ workshopper_content_url_prefix }}/demo-cicd-eap-full.yml
    workshopper_env_vars:
      PROJECT_SUFFIX: "-XX"
      OPENSHIFT_MASTER: "http://myopenshift.com:8443"
      GOGS_DEV_USER: "gogs"
      GOGS_DEV_PASSWORD: "gogs"
      GOGS_REVIEWER_USER: "developer"
      GOGS_REVIEWER_PASSWORD: "developer"
    openshift_cli: "oc --server http://master:8443"
```