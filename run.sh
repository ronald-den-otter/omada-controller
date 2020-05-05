#!/bin/bash
version=latest

mkdir -p /opt/tplink/$version/OmadaController/data
mkdir -p /opt/tplink/$version/OmadaController/work
mkdir -p /opt/tplink/$version/OmadaController/logs
ln -s /opt/tplink/$version/OmadaController /opt/tplink/OmadaController

groupadd -g 508 omadad
useradd -u 508 -g 508 -d /opt/tplink/OmadaController omadad

chown -R 508:508 /opt/tplink/$version/OmadaController

omadadata="/opt/tplink/$version/OmadaController/data"
omadawork="/opt/tplink/$version/OmadaController/work"
omadalogs="/opt/tplink/$version/OmadaController/logs"

# make a copy with new version like:
# cd /opt/tplink/$oldversion && tar -czvSf - OmadaController | tar -xzvSf - -C /opt/tplink/$version
# after testing rm -rf /opt/tplink/$oldversion

docker run -d \
--name omada-controller \
--network host \
--memory 900m \
-e TZ=Europe/Amsterdam \
-e SMALL_FILES=false \
-p 8088:8088   -p 8043:8043   -p 27001:27001/udp   -p 27002:27002   -p 29810:29810/udp   -p 29811:29811   -p 29812:29812   -p 29813:29813  \
-v $omadadata:/opt/tplink/OmadaController/data   -v $omadawork:/opt/tplink/OmadaController/work   -v $omadalogs:/opt/tplink/OmadaController/logs omada-controller:$version
# --network and --memory are optional
