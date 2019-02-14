#!/bin/bash
set -o pipefail
set -x
set -e

echo "+) Installing extra packages"
dnf -y install deltarpm \
    mlocate \
    cloud-init \
    cloud-utils-growpart \
    ntp \
    gdisk \
    vim \
    net-tools \
    bind-utils \
    curl \
    wget \
    rsync \
    git \
    telnet \
    traceroute \
    bridge-utils \
    iptables-services \
    dkms \
    make \
    gcc \
    gcc-c++ \
    bzip2 \
    jq \
    yum-utils \
    yum-cron \
    python-devel \
    python-pip \
    openssl-devel \
    libffi-devel \
    libtool \
    libtool-ltdl \
    NetworkManager \
    sysstat \
    screen \
    libattr-devel \
    libcurl-devel \
    bc \
    awscli

echo "+) Updating system packages"
yum update -y

echo "+) Let's make it easy to find all of our files"
updatedb
