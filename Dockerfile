ARG BASE_IMAGE=amazonlinux:2@sha256:3bc2191fa2d5f467217e5ca947485bc203b73c02b9a23b164818fa6e37647625
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-05-22
ARG SENZING_YUM_REPOSITORY_URL=https://senzing-production-yum.s3.amazonaws.com/senzingrepo_2.0.0-1_all.deb

LABEL Name="senzing/yum" \
  Maintainer="support@senzing.com" \
  Version="1.1.15"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via yum.

RUN yum -y update && yum -y install \
  https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm \
  ${SENZING_YUM_REPOSITORY_URL} \
  && yum -y update python*

# Copy files from repository.

COPY ./rootfs /

USER 1001

# Runtime execution.

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["-y", "install", "senzingapi"]
