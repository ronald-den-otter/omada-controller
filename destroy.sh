#!/bin/bash
docker stop omada-controller
docker rm omada-controller
docker rmi omada-controller:3.2.6-1
