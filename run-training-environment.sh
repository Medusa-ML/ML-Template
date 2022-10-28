#!/bin/bash

echo "starting dockerized training environment"
echo "🐍🧜💇"
sudo docker run -u $(id -u):$(id -g) -v $(pwd):/tf -it --rm -p 8888:8888  tensorflow/tensorflow:latest-jupyter
