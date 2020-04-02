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

This will start the container called omada-controller, which you can also use as name for starting it next time:

docker start omada-controller
