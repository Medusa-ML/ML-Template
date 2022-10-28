#!/bin/bash

echo "starting dockerized training environment with GPU support"
echo "this GPU environment will  only work on Linux-based OSes with nvidia-docker installed"
echo "for more invo on installing nvidia-docker see https://github.com/NVIDIA/nvidia-docker"
echo "🐍🧜💇"
sudo docker run --gpus all -u $(id -u):$(id -g) -v $(pwd):/tf -it --rm -p 8888:8888  tensorflow/tensorflow:latest-gpu-jupyter
