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
echo ""
echo "For community support join our discord at https://discord.gg/medusaml"
echo "================================================================================"
echo ""

echo "Select the base docker image to run (default is Ubuntu): (U)buntu/(P)yTorch/(T)ensorFlow. Press Enter for Ubuntu."
read framework
framework=$(echo $framework | tr '[:upper:]' '[:lower:]')
optional_installs=""

echo "Do you want to run open-interpreter? (Y)es/(N)o. Press Enter for No (default)."
read open_interpreter
open_interpreter=$(echo $open_interpreter | tr '[:upper:]' '[:lower:]')
user_setup=""
bash=""

echo "Do you have nvidia-docker installed and want to run on a GPU? (Y)es/(N)o. Press Enter for No (default)."
read use_gpu
use_gpu=$(echo $use_gpu | tr '[:upper:]' '[:lower:]')


echo "Do you want to skip building the container (you MUST run this at least once)? (Y)es/(N)o. Press Enter for No (default)."
read skip_build 
skip_build=$(echo $skip_build | tr '[:upper:]' '[:lower:]')


tag=""

case $framework in
    p|pytorch)
        framework="pytorch/pytorch:latest"
	optional_installs="--build-arg OPTIONAL_INSTALLS=true"
	tag+="-pytorch"
        ;;
    t|tensorflow)
        framework="tensorflow/tensorflow:latest-jupyter"
	tag+="-tensorflow"
        ;;
    u|ubuntu)
        framework="ubuntu:latest"
	tag+="-ubuntu"
        ;;
    *)
        framework="ubuntu:latest"
        tag+="-ubuntu"
	;;
esac

case $open_interpreter in
    y|yes)
        open_interpreter="--build-arg SETUP_ENTRYPOINT=true"
        bashopt="bash"
	user_setup="-e UID=$(id -u) -e GID=$(id -g)"
	tag+="-oi"
	;;
    n|no)
        open_interpreter=""
	bashopt=""
	user_setup="-u $(id -u):$(id -g)"
        ;;
    *)
        open_interpreter=""
	bashopt=""
	user_setup="-u $(id -u):$(id -g)"
        ;;
esac

case $use_gpu in
    y|yes)
        use_gpu="--gpus all"
        ;;
    n|no)
        use_gpu=""
        ;;
    *)
        use_gpu=""
        ;;
esac

no_cache=""

case $skip_build in
    y|yes)
	skip_build="yes"
	;;
    n|no)
        skip_build="no"
	echo "Do you want to force a refresh (--no-cache)? (Y)es/(N)o. Press Enter for No (default)."
	read no_cache 
	no_cache=$(echo $no_cache | tr '[:upper:]' '[:lower:]')
	case $no_cache in
		y|yes)
			no_cache="--no-cache"
			;;
		n|no)
			no_cache=""
			;;
		*)	
			no_cache=""
			;;
	esac
        ;;
    *)
        skip_build="no"
        ;;
esac


if [ "$skip_build" = "no" ]; then
	sudo docker build -f install/Dockerfile --build-arg BASE_IMAGE=$framework $optional_installs $open_interpreter -t mlt$tag . $no_cache
fi

sudo docker run $use_gpu $user_setup -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt$tag $bashopt

