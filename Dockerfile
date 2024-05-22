ARG BASE_IMAGE=amazonlinux:2@sha256:3bc2191fa2d5f467217e5ca947485bc203b73c02b9a23b164818fa6e37647625
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-05-22
ARG SENZING_YUM_REPOSITORY_URL=https://senzing-production-yum.s3.amazonaws.com/senzingrepo-1.0.0-1.x86_64.rpm

LABEL Name="senzing/yum" \
      Maintainer="support@senzing.com" \
      Version="1.1.13"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via yum.

RUN yum -y update && yum -y install \
    https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm \
    ${SENZING_YUM_REPOSITORY_URL}

RUN yum -y update python*

# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["-y", "install", "senzingapi"]
