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
