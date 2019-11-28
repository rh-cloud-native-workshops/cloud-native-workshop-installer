Ansible Role: Logging on OpenShift
[![Build Status](https://travis-ci.org/cvicens/ansible-cnw_logging.svg?branch=master)](https://travis-ci.org/cvicens/ansible-cnw_monitoring)
=========

Ansible Role for deploying prometheus 7 on OpenShift with Red Hat enterprise maven repositories preconfigured on prometheus

NOTE: This role has been updated to only support prometheus 7


Role Variables
------------

|Variable               | Default Value            | Description   |
|-----------------------|--------------------------|---------------|
|`prometheus_service_name`          | prometheus                    | prometheus service name on OpenShift  |
|`prometheus_image_version`         | 7.0                   | prometheus image version as available on Docker Hub for [prometheus 7](https://hub.docker.com/r/openshiftdemos/prometheus/tags/) |
|`prometheus_volume_capacity`       | 1Gi                     | Persistent volume capacity for prometheus  |
|`prometheus_max_memory`            | 6Gi                      | Max memory allocated to prometheus container |
|`prometheus_min_memory`            | 512Mi                    | Min memory allocated to prometheus container |
|`prometheus_max_cpu`               | 1                        | Max cpu allocated to prometheus container |
|`prometheus_min_cpu`               | 200m                     | Min cpu allocated to prometheus container |
|`prometheus_admin_user`            | adminuser                | prometheus admin user |
|`prometheus_admin_password`        | admin123                 | prometheus admin password |
|`current_prometheus_admin_password`| admin123                 | Admin password for current instance (if an existing instance needs reconfiguration) |
|`project_name`                | prometheus                    | OpenShift project name for the prometheus container  |
|`project_display_name`        | prometheus                    | OpenShift project display name for the prometheus container  |
|`project_desc`                | prometheus Repository Manager | OpenShift project description for the prometheus container |
|`project_annotations`         | -                        | OpenShift project annotations for the prometheus container |
|`openshift_cli`               | oc                       | OpenShift CLI command and arguments (e.g. auth)       | 


Example Playbook
------------

```
name: Example Playbook
hosts: localhost
tasks:
- import_role:
    name: cvicens.openshift_prometheus
  vars:
    project_name: "cicd-project"
    openshift_cli: "oc --server http://master:8443"
```