# Docker

## Installing Docker to localhost

Use instruction by following link <https://docs.docker.com/engine/install/ubuntu/>
Or use this script (learn limitations of this script in link above):

```bash
 curl -fsSL https://get.docker.com -o get-docker.sh
 DRY_RUN=1 sudo sh ./get-docker.sh
 ```

## Creating own custom image

* In directory `~/your_repo/docker-monolith` create file `Dockerfile`
* In `Dockerfile`, add the commands you need, which will be image layers (as an example, see the `Dockerfile` file).
* In the same directory place files which uses in `Dockerfile` and necessary by creating image
* To create image in directory `~/your_repo/docker-monolith` execute next command

```bash
docker build -t your_own_tag .
```

## Creating image for terraform with using packer and ansible role

In directory `~/your_repo/docker-monolith/infra/packer` execute follow command

```bash
packer build -var-file=variables.json app.json
```

## Running a docker container on a virtual machine running Terraform in GCP

* In terraform file setup variable in file `app_disk_image`, for this use image created with packer
* After that, in the command in order to create the virtual machines on gcp
* After that, in directory `~/your_repo/docker-monolith/infra/ansible` execute `ansible-playbook playbooks/monolith_container_launch.yml`
* To check the operability, navigate in your browser in the external addresses of your VM instances with the port that you specified in your playbook in this case it is `your_ip:9292`

## Creating a virtual machine in GCP using Docker-Machine

```bash
 docker-machine create --driver google \
 --google-project docker-86505 \
 --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts \
 --google-machine-type n1-standard-1 \
 --google-zone europe-west1-b \
 name_your_docker_host
```

To change the environment to the environment of the created VM

```bash
eval $(docker-machine env name_your_docker_host)
```

After that, all Docker-related commands will be executed on docker-host, to resume work on your local machine, run the command

```bash
 eval $(docker-machine env --unset)
```

## Creating own Docker Network

To create a bridge network for docker containers, use the following command

```bash
docker network create name_your_network
```

To create a VM on this bridge network, use the following syntax

```bash
docker run <launch option> --network=name_your_network <network option> your_image
# for example like this
docker run --rm -d --network=reddit -p 9292:9292 <your-dockerhub-login>/ui:1.0
# or
docker run -d --network=reddit --network-alias=post <your-dockerhub-login>/post:1.0
```

## Ways to reduce the size of your docker image

* Use smaller base images (FROM)
* Use chain operators (&&) to reduce the number of layers and delete the package manager cache
* Use multistage building
* Use Docker-squash (there are restrictions on the reuse of some functions, for example, image layers will not be available)

## Docker-Compose compose project name

The base name of a project is determined by `the name of the directory` that the `docker-compose.yml` file is located in.
By default, it can also be set by the `-p` or `--project-name` option when running `docker-compose` commands.
This can be useful if you want to run multiple projects in the same directory. The name can be overridden by the `COMPOSE_PROJECT_NAME` environment variable
in `.env` file.

## Gitlab CI device. Building a Continuous Delivery Process

### Install Omnibus

* In the directory `path-to-your-repo/docker-monolith/infra/packer` run `packer build -var-file=variables.json app.json` this command will create an image with Docker and Docker-compose preinstalled

* In the directory `path-to-your-repo/docker-monolith/infra/terraform/` , run `terraform init` and `terraform appy` to create a storage-bucket (add a unique suffix to the bucket name, for example, use the date 03032023 or the `timestamp()` function)

* In the directory `path-to-your-repo/docker-monolith/infra/terraform/infra`  in the `backend.tf` file, specify the unique name of your `storage-bucket`

* In the directory  `path-to-your-repo/docker-monolith/infra/terraform/app`  in the `backend.tf` file, specify the unique name of your `storage-bucket`

* In the directory `path-to-your-repo/docker-monolith/infra/terraform/infra` , run `terraform init` and `terraform apply` to create a virtual machine using the baked image created earlier with the packer

* Create a service account for your project in the GCP cloud <https://cloud.google.com/iam/docs/service-account-overview>

* In the directory `path-to-your-repo/docker-monolith/infra/ansible/environments/stage` , copy everything you need to use the ansible dynamic inventory (gce.py and gce.ini). In the gce.ini file, enter the path to the service account authorization file in the directory `path-to-your-repo/docker-monolith/infra/ansible/gce_py/` (<https://github.com/hortonworks/ansible-hortonworks>)

* In the directory `path-to-your-repo/docker-monolith/infra/ansible/` , run the command

```bash
ansible-playbook playbooks/gitlab_omnibus.yml # launching gitlab-ci
ansible-playbook playbooks/gitlab_runner.yml # launching gitlab-runner for pipeline. To launch, you need to copy and paste the token into your role, which is launched by this playbook <https://docs.gitlab.com/runner/>
ansible-playbook playbooks/attach_disk.yml # mounting an independent disk in which the cache of gitlab-ci and runner containers will be stored if you need to recreate a VM
ansible-playbook playbooks/omnibus_password.yml # to get the root password at the first launch of gitlab-ci. The password file will be deleted a day after you log in to your gitlab-ci (it is recommended to change it)
```

### Setting up gitlab-ci

* Either through terraform output or through the web interface of your project in GCP, find out the ip address of your VM with gitlab-ci installed

* Use this ip address in the address bar of your browser to go to the gitlab-ci login page

* Username `root` password you should get when executing `omnibus_password.yml`

* After log in, follow the recommendation of the web interface to disable the ability to create new users.

* Create a new group and create a new repository in the new group. In my case this is `homework`

* Add an SSH key for secure access to GitLab. <https://docs.gitlab.com/ee/user/ssh.tml#use-ssh-keys-to-communicate-with-gitlab>

* Add remote repository to your local host

```bash
 git remote add gitlab-ssh ssh://git@external_ip_your_vm:2222/homework/homework.git # pay attention to ssh:// just git@external_ip...homework.git it won't work
```

### Starting the pipeline

* In the project settings, you should add the following variables and files ( manual how to add <https://docs.gitlab.com/ee/ci/variables/#gitlab-cicd-variables>)

```bash
# Variables
APPUSER # your private key that you use to access the VM GCP when using terraform and ansible
APPUSER_PUB # public key, for installation on VM
DOCKER_HUB_USERNAME # your username on docker hub, use lower case
DOCKER_HUB_PASSWD # password for your docker hub account
GCE_INI # the contents of the gce.ini file must be identical to the one you specified when setting up the ansible inventory
GCLOUD_CREDENTIALS # the value of the variable contains the credentials of your service account. Used for dynamic generation when the ansible is running

# File
GOOGLE_APPLICATION_CREDENTIALS # contains the credentials of your service account. (your_cred.json file). Used to work terraform in your pipeline

# These files and variables will be used in your pipeline to provide authorizations and dynamic generation of some files inside your pipeline
```

* Pipeline startup parameters are described in the file `your_repo_path/gitlab-ci.yml`

* The directory `your_repo_path/gitlab-ci/Docker_images/`  contains the directory `gitlab_ansible` and `gitlab_terraform` with dockerfiles, which are used to create images used in `gitlab-ci.yml` (`your_user_name/gitlab-terraform:your_tag` and `your_docker_hub_user_name/gitlab-ansible:your_tag`)

* After perform a `git push` to the newly created repository, the pipeline for your project will be launched

* When creating a virtual machine in your pipeline, a new dynamic workspace will be created each time, the name of your workspace will be the name of your gitlab brunch

* The result of the pipeline execution will be a running Reddit Monolith application on a dynamically created VM. To access the application, use the external IP address of the newly created virtual machine. <http://your_external_ip:9292>

After the successful launch of the application and the health check, you need to manually configure the deletion of your virtual machine and workspace by running the reddit vm delete job via `Deployments => Environments` section or directly in your `CI/CD pipeline` in web interface.

## Monitoring systems

### Preparing infrastructure

* For Prometheus to work in GCP, you need to allow port 9090 in the firewall, for example, with the command

```bash
gcloud compute firewall-rules create prometheus-default --allow tcp:9090
# You can also use terraform
```

* VM creation and environment switching

```bash
docker-machine create --driver google --google-project docker-86505 \
    --google-machine-image https://www.googleapis.com/compute/v1/projects/your_project/global/images/your_image_with_docker_compose \
    --google-machine-type n1-standard-1 \
    --google-zone us-central1-a \
    --google-disk-size 20 \
    docker-host
eval $(docker-machine env docker-host)
```

* Launch container with prometheus

```bash
docker run --rm -p 9090:9090 -d --name prometheus prom/prometheus:v2.37.6
```

* To test the operation of prometheus, follow the link <http://your_vm_ip_address:9090> to check the metrics that prometheus collects <http://your_vm_ip_address:9090/metrics> (after that you can delete a container)

### Creating a monitoring system using docker-compose

* monitoring uses custom docker images built in the `monitoring` directory, as well as ready-made images such as prom/node-exporter:v0.15.2 and percona/mongodb_exporter:2.35.0, their configuration is specified in docker/docker-compose.yml

* You should also pay attention to the `monitoring/prometheus/prometheus.yml` file, which indicates what data and how Prometheus will collect.
* also, many exporters can configure its own collection rules, for example, in the file `monitoring/blackbox/blackbox.yml`

The directory `docker`  contains `docker-compose.yml`. This file has sections responsible for monitoring the rest of the infrastructure

* run by command

```bash
cd docker
docker-compose up -d
```

* to check the operation of the monitoring system, go to <http://your_vm_ip_address:9090>

### Collecting docker container metrics

The docker-compose.yml file contains the configuration of the containers responsible for the application. In the docker-compose-monitoring.yml file, the container configuration responsible for monitoring the state and collecting metrics was taken out.
To collect metrics from containers, cAvisor is used, the standard access port is `8080`. By default, access is allowed only for prometheus, but you can do port forwarding in docker-compose-monitoring.yml
In case of configuration changes, you need to rebuild images and rebuild containers.

```bash
docker build -t your_tag .
docker push your_tag
docker-compose rm -sf service_name
docker-compose up -d service_name
```

### Visualizing metrics with Grafana

The standard access port is `3000`. The your_repo/monitoring/grafana directory contains a file for building the image and then using it in a docker compose, also in this directory there is a dashboards directory that contains dashboards,
which will be preinstalled after creating the container, you can place your own dashboard there.This is the entry point for a regular user, through which the user gets access to all the metrics that prometheus collects
In case of configuration changes, you need to rebuild images and rebuild containers.

### Alertmanager

Alert triggering rules are configured through the `alerts.yml` file in the folder with the Prometheus image `your_repo/monitoring/prometheus`
The channel to which the alert is sent is configured in the `config.yml` file located in the directory `your_repo/monitoring/alertmanager`
In case of configuration changes, you need to rebuild images and rebuild containers.
