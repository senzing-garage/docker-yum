ARG BASE_IMAGE=amazonlinux:2023@sha256:2f10659a297494a1842d8b122027e3d865a7d4e5a88c056e53f45316ffc9c985
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2025-12-22
ARG SENZING_YUM_REPOSITORY_URL=https://senzing-production-yum.s3.amazonaws.com/senzingrepo-2.0.1-1.noarch.rpm

LABEL Name="senzing/yum" \
  Maintainer="support@senzing.com" \
  Version="1.1.16"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via yum.

RUN yum -y update && yum -y install \
  https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm \
  ${SENZING_YUM_REPOSITORY_URL} \
  && yum -y update python* \
  && yum clean all

# Copy files from repository.

COPY ./rootfs /

USER 1001

# Runtime execution.

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["-y", "install", "senzingapi"]
