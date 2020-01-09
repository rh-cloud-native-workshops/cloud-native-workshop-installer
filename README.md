# Cloud Native Workshop Installer

This is just a simple installer of common Red Hat Cloud Native workshops components using ansible in a kubernetes job. To run it just do as follows:

* Log in to your Red Hat Openshift Cluster as `cluster admin`
* Run this shell `./run-installer-job.sh`


This shell script `./run-installer-job.sh` runs a BatchJob, but before:

* Creates a namespace to run the job
* Creates a role, a service account and a role binding so that the job can create all the needed componentes
* Finally it runs the job `cnw-installer`

> This is not a replacement of other means to do the same, just another alternative

Once the installer job is running you can see logs by running:

```sh
oc logs -f jobs/cnw-installer
```

# The logic

All the logic in the job is in `./setup/preparelab_cnw.sh`, this script is run in the Job pod and by default executes a playbook called `./setup/playbooks/provision.yml`.

## Adding new logic

Add a new role in `./setup/playbook/roles` and use it in `provision.yml` or create your own playbook. If the latter remember to create a new Job and a new script, an example of this is `./run-installer-basic-job.sh`.

# The image run by the Job

You can run the job `as is` the image is should look like: `quay.io/cvicensa/cnw-installer:v0.0.2`

Or you can create our own, to do so:

1. Modify `build-image.sh` and change REGISTRY, REGISTRY_USER_ID, IMAGE_NAME, IMAGE_VERSION to fit your needs.
1. Modify `cnw-installer-batch.yaml` to use your image

