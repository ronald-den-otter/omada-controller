# omada-controller
Omada Controller on Raspberry PI 3B+ with raspian buster

Go to the following webpage and download omada-controller_3.2.6-1_all.deb

https://community.tp-link.com/en/business/forum/topic/162210

Place the downloaded file in the same directory as the Dockerfile

# Building the image
docker build --tag omada-controller:3.2.6 .

# First time run the image

chmod 700 run.sh
./run.sh

or in commands:
mkdir -p /opt/docker/tplink/OmadaController/data
mkdir -p /opt/docker/tplink/OmadaController/work
mkdir -p /opt/docker/tplink/OmadaController/logs

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
