ARG BASE_IMAGE=centos:7
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2019-09-01

LABEL Name="senzing/yum" \
      Maintainer="support@senzing.com" \
      Version="1.1.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via yum.

RUN yum -y install \
    https://senzing-production-yum.s3.amazonaws.com/senzingrepo-1.0.0-1.x86_64.rpm \
    https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm

# RUN curl https://packages.microsoft.com/config/centos/7/prod.repo > /etc/yum.repos.d/mssql-release.repo


# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

ENTRYPOINT ["yum"]
CMD ["-y", "install", "senzingdata-v1", "senzingapi"]
