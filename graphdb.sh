
FROM ubuntu:18.04.1

MAINTAINER Ivan Subotic "ivan.subotic@unibas.ch"

# Silence debconf messages
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -qq update && \
  apt-get -y install \
    byobu curl git htop man vim wget unzip \
    openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

# Install GraphDB-Free and clean up
RUN \
  curl -sS -o /tmp/graphdb.zip -L http://go.pardot.com/e/45622/38-graphdb-free-8-7-2-dist-zip/67bb36/1387841985 && \
  unzip /tmp/graphdb.zip -d /tmp && \
  mv /tmp/graphdb-free-8.2.0 /graphdb && \
  git clone -b develop --single-branch --depth=1 https://github.com/dhlab-basel/Knora.git /knora && \
  cp /knora/webapi/scripts/KnoraRules.pie /graphdb && \
  rm /tmp/graphdb.zip && \
  rm -rf /knora

# Set GraphDB Max and Min Heap size
ENV GDB_HEAP_SIZE="4g"

EXPOSE 7200
CMD ["/graphdb/bin/graphdb"]






 curl -fsSL https://get.docker.com -o test-docker.sh
