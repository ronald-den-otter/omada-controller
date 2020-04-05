#!/bin/bash
docker build --tag omada-controller:3.2.6-1 --no-cache . 2>&1
# docker tag omada-controller:3.2.6-1 ronald-den-otter/omada-controller:3.2.6-1
# docker push 
