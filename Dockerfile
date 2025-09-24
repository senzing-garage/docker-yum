ARG BASE_IMAGE=amazonlinux:2@sha256:fd92a6cabde62035fb2ecf8a8904e0a54de7898d2c63cf8b4ee37a0c8fff7ecb
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-06-24
ARG SENZING_YUM_REPOSITORY_URL=https://senzing-production-yum.s3.amazonaws.com/senzingrepo_2.0.0-1_all.deb

LABEL Name="senzing/yum" \
  Maintainer="support@senzing.com" \
  Version="1.1.16"

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
