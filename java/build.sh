#!/bin/sh

if ! command -v javac &> /dev/null; then
  echo "Please, install Java Development Kit (JDK) first"
  exit 1
fi

mkdir -p lib class tmp

COMMONS_DAEMON_VER=commons-daemon-1.4.0

wget \
  -O tmp/${COMMONS_DAEMON_VER}-bin.tar.gz \
  "https://downloads.apache.org/commons/daemon/binaries/${COMMONS_DAEMON_VER}-bin.tar.gz"
tar -C lib/ \
  --strip-components=1 \
  -zxvf tmp/${COMMONS_DAEMON_VER}-bin.tar.gz \
  ${COMMONS_DAEMON_VER}/${COMMONS_DAEMON_VER}.jar

javac -cp lib/${COMMONS_DAEMON_VER}.jar -d class/ src/*
jar cfe lib/pjbridge.jar Server -C class .
