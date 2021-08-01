ARG BASE_IMAGE=centos:7
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2021-07-31
ARG SENZING_YUM_REPOSITORY_URL=https://senzing-production-yum.s3.amazonaws.com/senzingrepo-1.0.0-1.x86_64.rpm

LABEL Name="senzing/yum" \
      Maintainer="support@senzing.com" \
      Version="1.1.4"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via yum.

RUN yum -y update && yum -y install \
    https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm \
    ${SENZING_YUM_REPOSITORY_URL}

RUN yum -y update python*

# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

ENTRYPOINT ["yum"]
CMD ["-y", "install", "senzingapi"]
