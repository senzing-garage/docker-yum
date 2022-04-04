ARG BASE_IMAGE=centos:8@sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2022-04-01
ARG SENZING_YUM_REPOSITORY_URL=https://senzing-production-yum.s3.amazonaws.com/senzingrepo-1.0.0-1.x86_64.rpm

LABEL Name="senzing/yum" \
      Maintainer="support@senzing.com" \
      Version="1.1.8"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via yum.

RUN yum -y update && yum -y install \
    https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm \
    ${SENZING_YUM_REPOSITORY_URL}

RUN yum -y update python*

# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

ENTRYPOINT ["yum"]
CMD ["-y", "install", "senzingapi"]
