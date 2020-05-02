#!/bin/bash
docker build --tag ronaldo1965/omada-controller:busterlatest --no-cache . 2>&1 &&\
docker push  ronaldo1965/omada-controller:busterlatest
