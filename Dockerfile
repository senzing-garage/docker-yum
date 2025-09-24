ARG BASE_IMAGE=amazonlinux:2023@sha256:4f02d5d4500105878af64950f9c46cde3392b907907cb0d23a885c721a26f67d
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-06-24
ARG SENZING_YUM_REPOSITORY_URL=https://senzing-production-yum.s3.amazonaws.com/senzingrepo_2.0.1-1_all.deb

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
