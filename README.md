# docker-yum

If you are beginning your journey with [Senzing],
please start with [Senzing Quick Start guides].

You are in the [Senzing Garage] where projects are "tinkered" on.
Although this GitHub repository may help you understand an approach to using Senzing,
it's not considered to be "production ready" and is not considered to be part of the Senzing product.
Heck, it may not even be appropriate for your application of Senzing!

## Synopsis

A docker wrapper around the `yum` command.

## Overview

This repository creates a Docker wrapper over the `yum` command.
It can be used to download and extract RPMs.
The default behavior is to install the latest `senzingapi` packages.

### Contents

1. [Expectations]
1. [Demonstrate using Docker]
   1. [EULA]
   1. [Docker volumes]
   1. [Run Docker container]
1. [Examples]
   1. [Examples of Docker]
   1. [Configuration]
1. [References]

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps there are some choices to be made.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

### Expectations

- **Space:** This repository and demonstration require 6 GB free disk space.
- **Time:** Budget 10 minutes to get the demonstration up-and-running, depending on CPU and network speeds.
- **Background knowledge:** This repository assumes a working knowledge of:
  - [Docker]

## Demonstrate using Docker

### EULA

To use the Senzing code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <pre>export SENZING_ACCEPT_EULA="&lt;the value from <a href="https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

1. Construct parameter for `docker run`.
   Example:

   ```console
   export SENZING_ACCEPT_EULA_PARAMETER="--env SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA}"
   ```

### Docker volumes

Senzing follows the [Linux File Hierarchy Standard]. The Senzing RPM installs 2 packages: `senzingapi`, `senzingdata`.
`senzingapi` is installed into `/opt/senzing/g2` and `senzingdata` is installed into `/opt/senzing/data` inside the Docker container.
Environment variables will be used in `--volume` options to externalize the installations.

1. :pencil2: Specify the directory where to install Senzing.
   Example:

   ```console
   export SENZING_VOLUME=/opt/my-senzing
   ```

   1. :warning:
      **macOS** - [File sharing MacOS] must be enabled for `SENZING_VOLUME`.
   1. :warning:
      **Windows** - [File sharing Windows] must be enabled for `SENZING_VOLUME`.

1. Identify directories for `data` and `g2`.
   Example:

   ```console
   export SENZING_DATA_DIR=${SENZING_VOLUME}/data
   export SENZING_G2_DIR=${SENZING_VOLUME}/g2
   ```

### Run Docker container

Although the `Docker run` command looks complex,
it accounts for all of the optional variations described above.
Unset environment variables have no effect on the
`docker run` command and may be removed or remain.

1. Run Docker container.
   Example:

   ```console
   sudo docker run \
     --rm \
     --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
     --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
     ${SENZING_ACCEPT_EULA_PARAMETER} \
     senzing/yum
   ```

1. When complete, Senzing is installed in the `SENZING_G2_DIR` and `SENZING_DATA_DIR` directories.
1. For more examples of use, see [Examples of Docker].

## Examples

### Examples of Docker

The following examples require initialization described in
[Demonstrate using Docker].

#### Manually accept EULA

By not setting `SENZING_ACCEPT_EULA_PARAMETER`, the containerized `yum` install will prompt for manual EULA acceptance.

1. Run Docker container.
   Example:

   ```console
   sudo docker run \
     --interactive \
     --rm \
     --tty \
     --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
     --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
     senzing/yum
   ```

#### Install local RPMs

`senzing/yum` can be used to install local RPM files.

1. To download Senzing RPM files, see
   [github.com/Senzing/docker-yumdownloader].

1. :pencil2: Set additional environment variables.
   Identify directory containing RPM files and the exact names of RPM files.
   Example:

   ```console
   export SENZING_RPM_DIR=~/Downloads
   export SENZING_API_RPM_FILENAME=senzingapi-nn.nn.nn.x86_64.rpm
   export SENZING_DATA_RPM_FILENAME=senzingdata-v1-nn.nn.nn.x86_64.rpm
   ```

1. Run the Docker container.
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

## Configuration

Configuration values specified by environment variable or command line parameter.

- **[SENZING_ACCEPT_EULA]**
- **[SENZING_API_RPM_FILENAME]**
- **[SENZING_DATA_RPM_FILENAME]**
- **[SENZING_RPM_DIR]**

## References

- [Development]
- [Errors]
- [Example Docs]
- Related artifacts:
  - [DockerHub]
  - [Helm Chart]
- [Verify container]

[Configuration]: #configuration
[Demonstrate using Docker]: #demonstrate-using-docker
[Development]: docs/development.md
[Docker volumes]: #docker-volumes
[Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker.md
[DockerHub]: https://hub.docker.com/r/senzing/yum
[Errors]: docs/errors.md
[EULA]: #eula
[Examples of Docker]: #examples-of-docker
[Examples]: #examples
[Example Docs]: docs/examples.md
[Expectations]: #expectations
[File sharing MacOS]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/share-directories-with-docker.md#macos
[File sharing Windows]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/share-directories-with-docker.md#windows
[github.com/Senzing/docker-yumdownloader]: https://github.com/senzing-garage/docker-yumdownloader
[Helm Chart]: https://github.com/senzing-garage/charts/tree/main/charts/senzing-yum
[Linux File Hierarchy Standard]: https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf
[References]: #references
[Run Docker container]: #run-docker-container
[Senzing Garage]: https://github.com/senzing-garage
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[SENZING_ACCEPT_EULA]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula
[SENZING_API_RPM_FILENAME]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_api_rpm_filename
[SENZING_DATA_RPM_FILENAME]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_data_rpm_filename
[SENZING_RPM_DIR]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_rpm_dir
[Senzing]: https://senzing.com/
[Verify container]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/verify-container.md
