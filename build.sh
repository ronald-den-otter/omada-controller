#!/bin/bash
docker build --tag omada-controller:3.2.6 . 2>&1 | tee /var/log/build_dockimage.log
