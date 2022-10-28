#!/bin/bash

echo "starting dockerized training environment in Windoze"
echo "🐍🧜💇"
docker run  -v ${pwd}:/tf -it --rm -p 8888:8888  tensorflow/tensorflow:latest-jupyter
