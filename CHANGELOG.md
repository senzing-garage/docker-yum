# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
[markdownlint](https://dlaa.me/markdownlint/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.14] - 2023-10-27

### Changed in 1.1.14

- Support `linux/arm64`

## [1.1.13] - 2023-09-30

### Changed in 1.1.13

- In `Dockerfile`, updated FROM instruction to `amazonlinux:2@sha256:7c24b50b9f0ad83b7219edb704962f361bcf3ec85fdfd302121159bf0d0a6cb7`

## [1.1.12] - 2023-05-11

### Changed in 1.1.12

- In `Dockerfile`, updated FROM instruction to `amazonlinux:2@sha256:3385565b4b75c4f15fd59a5dd7e4510ac5ad4b1825df9deed6be6af1092c8829`

## [1.1.11] - 2023-01-16

### Changed in 1.1.11

- In `Dockerfile`, updated FROM instruction to `amazonlinux:2@sha256:217c5852461fafd257cf72f82ac37f5317fbb74036d28fbb8228b0e195b9f2c7`

## [1.1.10] - 2022-09-29

### Changed in 1.1.10

- In `Dockerfile`, updated FROM instruction to `amazonlinux:2@sha256:b393108d01e77ff923d602f837fabb1aa545e8b913fbb1f7130d2ca30bde3c54`

## [1.1.9] - 2022-04-21

### Changed in 1.1.9

- updated to clean up the yum repos at runtime

## [1.1.8] - 2022-01-31

### Changed in 1.1.8

- Updated to use amazonlinux:2@sha256:ffc013f79b36a2c0352b444f5322ff43de25152a8ac1ad0fa473e90f1cbedcbe

## [1.1.7] - 2022-01-31

### Changed in 1.1.7

- Updated to use centos:8@sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177

## [1.1.6] - 2021-08-02

### Changed in 1.1.6

- Updated to use CentOS 8 base image

## [1.1.5] - 2021-07-31

### Changed in 1.1.5

- Updated to update installed packages

## [1.1.4] - 2021-02-12

### Changed in 1.1.4

- Make Senzing YUM repository URL a docker build argument. (`SENZING_YUM_REPOSITORY_URL`)

## [1.1.3] - 2020-01-27

### Deleted in 1.1.3

- Specific mention of `senzingdata-v1` is deleted.
  It is automatically installed via `senzingapi` dependency.

## [1.1.2] - 2019-11-13

### Changed in 1.1.2

- Added support for MSSQL.

## [1.1.1] - 2019-10-24

### Added in 1.1.1

- Fix package name to senzingdata-v1

## [1.1.0] - 2019-09-01

### Added in 1.1.0

- Now installs 2 packages (senzingdata, senzingapi)

## [1.0.0] - 2019-08-05

### Added in 1.0.0

- Basic wrapper over **yum**
