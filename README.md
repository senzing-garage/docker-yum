# docker-yum

## Overview

This repository is a wrapper over the `yum` command.
It can be used to download and extract RPMs.

The running docker container installs the latest `senzingapi` packages.

### Related artifacts

1. [DockerHub](https://hub.docker.com/r/senzing/yum)
1. [Helm Chart](https://github.com/Senzing/charts/tree/master/charts/senzing-yum)

### Contents

1. [Expectations](#expectations)
    1. [Space](#space)
    1. [Time](#time)
    1. [Background knowledge](#background-knowledge)
1. [Demonstrate using Docker](#demonstrate-using-docker)
    1. [EULA](#eula)
    1. [Volumes](#volumes)
    1. [Run docker container](#run-docker-container)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Advanced](#advanced)
    1. [Configuration](#configuration)
    1. [Run docker container on local file](#run-docker-container-on-local-file)
1. [Errors](#errors)
1. [References](#references)

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps you'll need to make some choices.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Expectations

### Space

This repository and demonstration require 6 GB free disk space.

### Time

Budget 10 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

### Background knowledge

This repository assumes a working knowledge of:

1. [Docker](https://github.com/Senzing/knowledge-base/blob/master/WHATIS/docker.md)

## Demonstrate using Docker

### EULA

To use the Senzing code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <code>export SENZING_ACCEPT_EULA="&lt;the value from [this link](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_accept_eula)&gt;"</code>

1. Construct parameter for `docker run`.
   Example:

    ```console
    export SENZING_ACCEPT_EULA_PARAMETER="--env SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA}"
    ```

### Volumes

Senzing follows the [Linux File Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf).
The Senzing installation installs 2 packages: `senzingapi`, `senzingdata`.
`senzingapi` is installed into `/opt/senzing/g2` and `senzingdata` is installed into `/opt/senzing/data` inside the docker container.
Environment variables will be used in `--volume` options to externalize the installations.

1. :pencil2: Specify the directory where to install Senzing.
   Example:

    ```console
    export SENZING_VOLUME=/opt/my-senzing
    ```

    1. :warning:
       **macOS** - [File sharing](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/share-directories-with-docker.md#macos)
       must be enabled for `SENZING_VOLUME`.
    1. :warning:
       **Windows** - [File sharing](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/share-directories-with-docker.md#windows)
       must be enabled for `SENZING_VOLUME`.

1. Identify the `data` and `g2` directories.
   Example:

    ```console
    export SENZING_DATA_DIR=${SENZING_VOLUME}/data
    export SENZING_G2_DIR=${SENZING_VOLUME}/g2
    ```

### Run docker container

1. Run the docker container.
   Example:

    ```console
    sudo docker run \
      --rm \
      --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      ${SENZING_ACCEPT_EULA_PARAMETER} \
      senzing/yum
    ```

## Develop

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-git.md)
1. [make](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-make.md)
1. [docker](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-docker.md)

### Clone repository

For more information on environment variables,
see [Environment Variables](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md).

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=senzing
    export GIT_REPOSITORY=docker-yum
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Follow steps in [clone-repository](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/clone-repository.md) to install the Git repository.

### Build docker image for development

1. **Option #1:** Using `docker` command and GitHub.

    ```console
    sudo docker build \
      --tag senzing/yum \
      https://github.com/senzing/docker-yum.git
    ```

1. **Option #2:** Using `docker` command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/yum .
    ```

1. **Option #3:** Using `make` command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo make docker-build
    ```

    Note: `sudo make docker-build-development-cache` can be used to create cached docker layers.

## Examples

## Advanced

### Configuration

Configuration values specified by environment variable or command line parameter.

- **[SENZING_ACCEPT_EULA](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_accept_eula)**
- **[SENZING_API_RPM_FILENAME](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_api_rpm_filename)**
- **[SENZING_DATA_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_data_dir)**
- **[SENZING_DATA_RPM_FILENAME](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_data_rpm_filename)**
- **[SENZING_G2_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_g2_dir)**
- **[SENZING_RPM_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_rpm_dir)**

### Run docker container on local file

`senzing/yum` can be used to install local RPM files.

1. To download Senzing RPM file, see
   [github.com/Senzing/docker-yumdownloader](https://github.com/Senzing/docker-yumdownloader).

1. :pencil2: Set environment variables.
   Identify directory containing RPM files
   and the exact name of the RPM files.
   Example:

    ```console
    export SENZING_RPM_DIR=~/Downloads
    export SENZING_API_RPM_FILENAME=senzingapi-nn.nn.nn.x86_64.rpm
    export SENZING_DATA_RPM_FILENAME=senzingdata-v1-nn.nn.nn.x86_64.rpm
    ```

1. Run the docker container.
   Example:

    ```console
    sudo docker run \
      --rm \
      --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      --volume ${SENZING_RPM_DIR}:/data \
      ${SENZING_ACCEPT_EULA_PARAMETER} \
      senzing/yum -y localinstall \
        /data/${SENZING_DATA_RPM_FILENAME} \
        /data/${SENZING_API_RPM_FILENAME}
    ```

## Errors

1. See [docs/errors.md](docs/errors.md).

## References
