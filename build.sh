#!/bin/bash
#docker build --tag ronaldo1965/omada-controller:latest --no-cache . 2>&1
docker build --tag ronaldo1965/omada-controller:3.2.10-1 --no-cache . 2>&1 &&\
docker push  ronaldo1965/omada-controller:3.2.10-1
