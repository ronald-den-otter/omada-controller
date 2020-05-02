FROM balenalib/rpi-raspbian:latest
HEALTHCHECK --start-period=5m CMD wget --quiet --tries=1 --no-check-certificate http://127.0.0.1:8088 || exit 1
MAINTAINER Ronald den Otter <ronald.den.otter@gmail.com>

COPY entrypoint.sh /entrypoint.sh

# install omada controller (instructions taken from install.sh); then create a user & group and set the appropriate file system permissions
RUN \
  echo "**** Install Dependencies ****" &&\
  apt-get update &&\
  DEBIAN_FRONTEND="noninteractive" apt-get install -y gosu net-tools tzdata wget curl mongodb openjdk-8-jdk-headless --no-install-recommends &&\
  DEBIAN_FRONTEND="noninteractive" apt-get -y clean all &&\
  rm -rf /var/lib/apt/lists/* &&\
  echo "**** Setup omada User Account ****" &&\
  groupadd -g 508 omadad &&\
  useradd -u 508 -g 508 -d /opt/tplink/OmadaController omadad &&\
  echo "*** Download Omada Controller ****" &&\
  cd /tmp &&\
  wget ftp://ftp.rent-a-guru.de/private/omada-controller_3.2.10-1_all.deb &&\
  echo exit 101 > /usr/sbin/policy-rc.d &&\
  chmod +x /usr/sbin/policy-rc.d &&\
  echo "**** Install Omada Controller ****" &&\
  DEBIAN_FRONTEND="noninteractive" dpkg -i /tmp/omada-controller_3.2.10-1_all.deb &&\
  rm -f /tmp/omada-controller_3.2.10-1_all.deb && rm -f /usr/sbin/policy-rc.d 

WORKDIR /opt/tplink/OmadaController
EXPOSE 8088 8043 27001/udp 27002 29810/udp 29811 29812 29813
VOLUME ["/opt/tplink/OmadaController/data","/opt/tplink/OmadaController/work","/opt/tplink/OmadaController/logs"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/lib/jvm/java-1.8.0-openjdk-armhf/jre/bin/java","-server","-Xms128m","-Xmx1024m","-XX:MaxHeapFreeRatio=60","-XX:MinHeapFreeRatio=30","-XX:+HeapDumpOnOutOfMemoryError","-XX:-UsePerfData","-Deap.home=/opt/tplink/OmadaController","-cp","/opt/tplink/OmadaController/lib/*:","com.tp_link.eap.start.EapLinuxMain"]
