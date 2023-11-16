#!/bin/bash

# Print introduction to the terminal
echo "================================================================================"
echo "Welcome to the Medusa Project Docker Setup Script"
echo "================================================================================"
echo "This script provides an efficient solution for building Docker images tailored to"
echo "machine learning environments. It supports the latest versions of PyTorch and"
echo "TensorFlow, as well as a basic Ubuntu setup with Scikit-Learn."
echo ""
echo "Designed for compatibility across various systems with Docker installed, this"
echo "script is optimized for Linux users with nvidia-docker, offering enhanced"
echo "performance for machine learning applications."
echo ""
echo "The Medusa Project is committed to delivering state-of-the-art technology"
echo "solutions for your machine learning projects, ensuring a seamless and"
echo "productive user experience."
echo "================================================================================"
echo ""

echo "Do you want to run vanilla Ubuntu, PyTorch or TensorFlow? (U)buntu/(P)yTorch/(T)ensorFlow"
read framework
framework=$(echo $framework | tr '[:upper:]' '[:lower:]')

echo "Do you want to run open-interpreter? (Y)es/(N)o"
read open_interpreter
open_interpreter=$(echo $open_interpreter | tr '[:upper:]' '[:lower:]')

echo "Do you have nvidia-docker installed and want to run on a GPU? (Y)es/(N)o"
read use_gpu
use_gpu=$(echo $use_gpu | tr '[:upper:]' '[:lower:]')

echo "Do you want to rebuild from scratch? (--no-cache)? (Y)es/(N)o"
read no_cache 
no_cache=$(echo $no_cache | tr '[:upper:]' '[:lower:]')

case $framework in
    p|pytorch)
        framework="pytorch"
        ;;
    t|tensorflow)
        framework="tensorflow"
        ;;
    u|ubuntu)
        framework="ubuntu"
        ;;
    *)
        echo "Invalid input for framework. Defaulting to Ubuntu."
        framework="ubuntu"
        ;;
esac

case $open_interpreter in
    y|yes)
        open_interpreter="yes"
        ;;
    n|no)
        open_interpreter="no"
        ;;
    *)
        echo "Invalid input for open-interpreter. Defaulting to No."
        open_interpreter="no"
        ;;
esac

case $use_gpu in
    y|yes)
        use_gpu="yes"
        ;;
    n|no)
        use_gpu="no"
        ;;
    *)
        echo "Invalid input for GPU usage. Defaulting to No."
        use_gpu="no"
        ;;
esac

case $no_cache in
    y|yes)
        no_cache="--no-cache"
        ;;
    n|no)
        no_cache=""
        ;;
    *)
        echo "Invalid input for cache clearing, Defaulting tousing cache."
        no_cache=""
        ;;
esac

if [ "$framework" = "pytorch" ]; then
if [ "$open_interpreter" = "yes" ] && [ "$use_gpu" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg OPTIONAL_INSTALLS=true --build-arg SETUP_ENTRYPOINT=true -t mlt . $no_cache
    sudo docker run --gpus all -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt
elif [ "$open_interpreter" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg OPTIONAL_INSTALLS=true --build-arg SETUP_ENTRYPOINT=true -t mlt . $no_cache
    sudo docker run -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt bash
elif [ "$use_gpu" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg OPTIONAL_INSTALLS=true -t mlt . $no_cache
    sudo docker run --gpus all -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt
else
    sudo docker build -f install/Dockerfile --build-arg OPTIONAL_INSTALLS=true -t mlt . $no_cache
    sudo docker run -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt
fi
elif [ "$framework" = "tensorflow" ]; then
if [ "$open_interpreter" = "yes" ] && [ "$use_gpu" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=tensorflow/tensorflow:latest-jupyter --build-arg SETUP_ENTRYPOINT=true  -t mlt . $no_cache
    sudo docker run --gpus all -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt bash
elif [ "$open_interpreter" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=tensorflow/tensorflow:latest-jupyter --build-arg SETUP_ENTRYPOINT=true -t mlt . $no_cache
    sudo docker run -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt bash
elif [ "$use_gpu" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=tensorflow/tensorflow:latest-jupyter -t mlt . $no_cache
    sudo docker run --gpus all -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt
else
    sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=tensorflow/tensorflow:latest-jupyter -t mlt . $no_cache
    sudo docker run -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt
fi
elif [ "$framework" = "ubuntu" ]; then
if [ "$open_interpreter" = "yes" ] && [ "$use_gpu" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=ubuntu:latest --build-arg SETUP_ENTRYPOINT=true -t mlt . $no_cache
    sudo docker run --gpus all -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt bash
elif [ "$open_interpreter" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=ubuntu:latest --build-arg SETUP_ENTRYPOINT=true -t mlt . $no_cache
    sudo docker run -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt bash
elif [ "$use_gpu" = "yes" ]; then
    sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=ubuntu:latest -t mlt . $no_cache
    sudo docker run --gpus all -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt
else
    sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=ubuntu:latest -t mlt . $no_cache
    sudo docker run -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt
fi
fi

