Role Name
=========

This role runs a docker container on a VM in the GCP cloud

Role Variables
--------------

`env:` the environment variable, in this case, shows in which environment the dynamic inventory is formed
`reddit_monolith_docker_image:` - a variable that specifies an image with a pre-installed docker-ce
`monolith_reddit_access_port:` port to access the application inside the container, also, this port must be setup in the rules of the GCP firewall

Example Playbook
----------------

In file  ansible/roles/defaults/main.yml the variables and their values are presented, which will be used if the variables are not redefined in the folder ansible/environments/

```yml
env: local
reddit_monolith_docker_image: fallgeratoor/otus-reddit:1.0
monolith_reddit_access_port: 9292
```

In file ansible/roles/tasks/container_launcher.yml, the syntax for using these variables is shown

```yml
- name: Launch a Docker container
  ansible.builtin.docker_container:
    name: reddit
    image: "{{ reddit_monolith_docker_image }}"
    state: started
    restart_policy: always
    network_mode: bridge
    ports:
      - "{{ monolith_reddit_access_port }}:9292"
```
