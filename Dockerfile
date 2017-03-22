FROM mamohr/centos-java:jre8

MAINTAINER Mario Mohr <mohr.mario@gmail.com>

RUN \
  yum update -y && \
  yum install -y epel-release && \
  yum install -y net-tools python-setuptools hostname inotify-tools yum-utils && \
  yum clean all && \
  easy_install supervisor

ENV FILE https://downloads-guests.open.collab.net/files/documents/61/17071/CollabNetSubversionEdge-5.2.0_linux-x86_64.tar.gz

RUN wget -q ${FILE} -O /tmp/csvn.tgz && \
    mkdir -p /opt/csvn && \
    tar -xzf /tmp/csvn.tgz -C /opt/csvn --strip=1 && \
    rm -rf /tmp/csvn.tgz

ENV RUN_AS_USER collabnet


RUN useradd collabnet && \
    chown -R collabnet.collabnet /opt/csvn && \
    cd /opt/csvn && \
    ./bin/csvn install && \
    mkdir -p ./data-initial && \
    cp -r ./data/* ./data-initial

EXPOSE 3343 4434 18080

ADD files /

VOLUME /opt/csvn/data

WORKDIR /opt/csvn

ENTRYPOINT ["/config/bootstrap.sh"]
