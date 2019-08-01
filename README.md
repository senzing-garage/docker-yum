# docker-yum

## :construction: Under construction

This repository is work in anticipation of an improved method of installing Senzing.
Until this comes out of "under construction" mode, please use
[senzing/senzing-package](https://github.com/Senzing/senzing-package) repository and
[store/senzing/senzing-package](https://hub.docker.com/_/senzing-package) docker image.

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
    1. [Volumes](#volumes)
    1. [Run docker container](#run-docker-container)
    1. [Run docker container interactively](#run-docker-container-interactively)
    1. [Run docker container on local file](#run-docker-container-on-local-file)
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

* **SENZING_ACCEPT_EULA** -
  This is your acceptance of the End User License Agreement (EULA).
  The EULA is located at
  [https://senzing.com/end-user-license-agreement](https://senzing.com/end-user-license-agreement/).
  If you accept the EULA, set the value of `SENZING_ACCEPT_EULA` to `I_ACCEPT_THE_SENZING_EULA`.
  Example shown below.

### EULA

To use the Senzing code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   See [Configuration](#configuration) for the correct value.
   Replace the double-quote character in the example with the correct value.
   The use of the double-quote character is intentional to prevent simple copy/paste.

   Example:

    ```console
    export SENZING_ACCEPT_EULA="
    ```

### Volumes

The output of `yum install senzingapi` will be in different directories.
Create a folder for each output directory.

1. :pencil2: Identify directories for RPM output.
   Example:

    ```console
    export SENZING_VOLUME=/tmp/senzing-yum-test

    export SENZING_DATA_DIR=${SENZING_VOLUME}/data
    export SENZING_G2_DIR=${SENZING_VOLUME}/g2
    export SENZING_ETC_DIR=${SENZING_VOLUME}/etc
    export SENZING_VAR_DIR=${SENZING_VOLUME}/var
    ```

### Run docker container

1. Run the docker container with programmatic EULA acceptance.
   Example:

    ```console
    sudo docker run \
      --env SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA} \
      --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      --volume ${SENZING_ETC_DIR}:/etc/opt/senzing \
      --volume ${SENZING_VAR_DIR}:/var/opt/senzing \
      senzing/yum
    ```

### Run docker container interactively

1. Run the docker container. User accepts EULA manually.
   Example:

    ```console
    sudo docker run \
      --interactive \
      --tty \
      --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      --volume ${SENZING_ETC_DIR}:/etc/opt/senzing \
      --volume ${SENZING_VAR_DIR}:/var/opt/senzing \
      senzing/yum
    ```

### Run docker container on local file

1. :pencil2: Identify directory containing RPM file.
   Example:

    ```console
    export SENZING_RPM_DIR=~/Downloads
    ```

1. Run the docker container.  Example:

    ```console
    sudo docker run \
      --interactive \
      --tty \
      --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      --volume ${SENZING_ETC_DIR}:/etc/opt/senzing \
      --volume ${SENZING_VAR_DIR}:/var/opt/senzing \
      --volume ${SENZING_RPM_DIR}:/data \
      senzing/yum -y localinstall /data/senzingapi-1.10.0-19190.x86_64.rpm
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

1. Option #1 - Using docker command and GitHub.

    ```console
    sudo docker build --tag senzing/yum https://github.com/senzing/docker-yum.git
    ```

1. Option #2 - Using docker command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/yum .
    ```

1. Option #3 - Using make command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo make docker-build
    ```

## Examples

## Errors

1. See [docs/errors.md](docs/errors.md).

## References
