# docker-yum

## Overview

This repository is a wrapper over the `yum` command.
It can be used to download and extract RPMs.

### Contents

1. [Expectations](#expectations)
    1. [Space](#space)
    1. [Time](#time)
    1. [Background knowledge](#background-knowledge)
1. [Demonstrate](#demonstrate)
    1. [Configuration](#configuration)
    1. [Run docker container interactively](#run-docker-container-interactively)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Errors](#errors)
1. [References](#references)

## Expectations

### Space

This repository and demonstration require 10 MB free disk space.

### Time

Budget 10 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

### Background knowledge

This repository assumes a working knowledge of:

1. [Docker](https://github.com/Senzing/knowledge-base/blob/master/WHATIS/docker.md)

## Demonstrate

### Configuration

* **ACCEPT_EULA** -
  This is your acceptance of the End User License Agreement (EULA).
  The EULA is located at
  [https://senzing.com/end-user-license-agreement](https://senzing.com/end-user-license-agreement/).
  If you accept the EULA, set the value of `ACCEPT_EULA` to `Y`.  Example shown below.

### Volumes

The output of `yum` will be in different directories.
Create a folder for each output directory.

1. :pencil2: Identify directories for RPM output.
   Example:

    ```console
    export SENZING_VOLUME=/tmp/senzing-yum-test

    export SENZING_DATA=${SENZING_VOLUME}/data
    export SENZING_G2=${SENZING_VOLUME}/g2
    export SENZING_ETC=${SENZING_VOLUME}/etc
    export SENZING_VAR=${SENZING_VOLUME}/var
    ```

1. Make directories.
   Example:

    ```console
    mkdir -p ${SENZING_DATA}
    mkdir -p ${SENZING_G2}
    mkdir -p ${SENZING_ETC}
    mkdir -p ${SENZING_VAR}
    ```

### Run docker container

1. Run the docker container.  Example:

    ```console
    sudo docker run \
      --env ACCEPT_EULA=Y \
      --volume ${SENZING_DATA}:/opt/senzing/data \
      --volume ${SENZING_G2}:/opt/senzing/g2 \
      --volume ${SENZING_ETC}:/etc/opt/senzing \
      --volume ${SENZING_VAR}:/var/opt/senzing \
      senzing/yum
    ```

### Run docker container interactively

1. Run the docker container.  Example:

    ```console
    sudo docker run \
      --interactive \
      --tty \
      --volume ${SENZING_DATA}:/opt/senzing/data \
      --volume ${SENZING_G2}:/opt/senzing/g2 \
      --volume ${SENZING_ETC}:/etc/opt/senzing \
      --volume ${SENZING_VAR}:/var/opt/senzing \
      senzing/yum
    ```

### Run docker container on local file

1. :pencil2: Identify directory containing file.
   Example:

    ```console
    export SENZING_RPM=~/Downloads
    ```

1. Run the docker container.  Example:

    ```console
    sudo docker run \
      --interactive \
      --tty \
      --volume ${SENZING_DATA}:/opt/senzing/data \
      --volume ${SENZING_G2}:/opt/senzing/g2 \
      --volume ${SENZING_ETC}:/etc/opt/senzing \
      --volume ${SENZING_VAR}:/var/opt/senzing \
      --volume ${SENZING_RPM}:/data \
      senzing/yum -y localinstall /data/senzingapi-1.10.19177-1.x86_64.rpm
    ```

## Develop

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-git.md)
1. [make](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-make.md)
1. [docker](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-docker.md)

### Clone repository

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=senzing
    export GIT_REPOSITORY=docker-yum
    ```

1. Follow steps in [clone-repository](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/clone-repository.md) to install the Git repository.

1. After the repository has been cloned, be sure the following are set:

    ```console
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

### Build docker image for development

1. Option #1 - Using `docker` command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/yum .
    ```

1. Option #2 - Using `make` command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo make docker-build
    ```

## Examples

## Errors

1. See [docs/errors.md](docs/errors.md).

## References
