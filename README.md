# ansible_docker

Docker image for docker

## Usage

```bash
$ make

  TARGETS
    build  ... Build docker image um7a/ansible
    clean  ... Clean docker image um7a/ansible
    run    ... Run docker container using image um7a/ansible
    attach ... Attach on docker container using image um7a/ansible
    stop   ... Stop docker container which was created by run target

```

## Build docker image

```bash
$ make build
```

## Run container

```bash
$ make run
```

If you mount a playbook directory

```bash
$ make run PLAYBOOK_PATH=<path to directory>
```

The directory is mounted to `/opt/playbook`

## Stop container

```bash
$ make stop
```

## Delete docker image

```bash
$ make clean
```
