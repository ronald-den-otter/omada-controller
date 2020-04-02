FROM raspbian/stretch
HEALTHCHECK --start-period=5m CMD wget --quiet --tries=1 --no-check-certificate http://127.0.0.1:8088 || exit 1
MAINTAINER Ronald den Otter <ronald.den.otter@gmail.com>


COPY entrypoint.sh /entrypoint.sh
COPY omada-controller_3.2.6-1_all.deb /tmp/omada-controller_3.2.6-1_all.deb

# install omada controller (instructions taken from install.sh); then create a user & group and set the appropriate file system permissions
RUN \
  echo "**** Install Dependencies ****" &&\
  apt-get update &&\
  DEBIAN_FRONTEND="noninteractive" apt-get install -y gosu net-tools tzdata wget curl mongodb oracle-java8-jdk jsvc &&\
  rm -rf /var/lib/apt/lists/* &&\
  echo "**** Setup omada User Account ****" &&\
  groupadd -g 508 omadad &&\
  useradd -u 508 -g 508 -d /opt/tplink/OmadaController omadad

RUN \
  echo "**** Install Omada Controller ****" &&\
  cd /tmp &&\
  DEBIAN_FRONTEND="noninteractive" dpkg -i /tmp/omada-controller_3.2.6-1_all.deb &&\
  rm -f /tmp/omada-controller_3.2.6-1_all.deb

WORKDIR /opt/tplink/OmadaController
EXPOSE 8088 8043 27001/udp 27002 29810/udp 29811 29812 29813
VOLUME ["/opt/tplink/OmadaController/data","/opt/tplink/OmadaController/work","/opt/tplink/OmadaController/logs"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/jre/bin/java","-server","-Xms128m","-Xmx1024m","-XX:MaxHeapFreeRatio=60","-XX:MinHeapFreeRatio=30","-XX:+HeapDumpOnOutOfMemoryError","-XX:-UsePerfData","-Deap.home=/opt/tplink/OmadaController","-cp","/opt/tplink/OmadaController/lib/*:","com.tp_link.eap.start.EapLinuxMain"]
