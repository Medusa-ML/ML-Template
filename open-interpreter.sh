#!/bin/bash

echo "starting dockerized open-interpreter environment"
echo "🐍🧜💇"
sudo docker run -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 pytorch-jupyter-openai bash 
