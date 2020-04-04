#!/bin/bash
mkdir -p /opt/tplink/OmadaController/data
mkdir -p /opt/tplink/OmadaController/work
mkdir -p /opt/tplink/OmadaController/logs

chown -R 508:508 /opt/docker/tplink

omadadata="/opt/docker/tplink/OmadaController/data"
omadawork="/opt/docker/tplink/OmadaController/work"
omadalogs="/opt/docker/tplink/OmadaController/logs"

docker run -d \
--name omada-controller \
-e TZ=Europe/Amsterdam \
-e SMALL_FILES=true \
-p 8088:8088   -p 8043:8043   -p 27001:27001/udp   -p 27002:27002   -p 29810:29810/udp   -p 29811:29811   -p 29812:29812   -p 29813:29813  \
-v $omadadata:/opt/tplink/OmadaController/data   -v $omadawork:/opt/tplink/OmadaController/work   -v $omadalogs:/opt/tplink/OmadaController/logs omada-controller:3.2.6 
