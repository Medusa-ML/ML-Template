#!/bin/bash

echo "starting dockerized training environment in Windoze"
sudo docker run  -v ${pwd}:/tf -it --rm -p 8888:8888  tensorflow/tensorflow:latest-jupyter
