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
