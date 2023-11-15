#!/bin/bash

echo "Are you on a Mac? (yes/no)"
read is_mac

if [ "$is_mac" = "yes" ]; then
    sudo docker build -f install/Dockerfile-mac -t mlt-mac .
    sudo docker run -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt-mac
else
    echo "Do you want to run in PyTorch or TensorFlow? (pytorch/tensorflow)"
    read framework

    echo "Do you want to run open-interpreter? (yes/no)"
    read open_interpreter

    echo "Do you have nvidia-docker installed and want to run on a GPU? (yes/no)"
    read use_gpu

    if [ "$framework" = "pytorch" ]; then
        if [ "$open_interpreter" = "yes" ] && [ "$use_gpu" = "yes" ]; then
            sudo docker build -f install/Dockerfile-pi -t mlt-pi .
            sudo docker run --gpus all -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt-pi
        elif [ "$open_interpreter" = "yes" ]; then
            sudo docker build -f install/Dockerfile-pi -t mlt-pi .
            sudo docker run -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt-pi
        elif [ "$use_gpu" = "yes" ]; then
            sudo docker build -f install/Dockerfile-p -t mlt-p .
            sudo docker run --gpus all -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt-p
        else
            sudo docker build -f install/Dockerfile-p -t mlt-p .
            sudo docker run -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 mlt-p
        fi
    elif [ "$framework" = "tensorflow" ]; then
        if [ "$open_interpreter" = "yes" ] && [ "$use_gpu" = "yes" ]; then
            sudo docker build -f install/Dockerfile-t -t mlt-t .
            sudo docker run --gpus all -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt-t
        elif [ "$open_interpreter" = "yes" ]; then
            sudo docker build -f install/Dockerfile-t -t mlt-t .
            sudo docker run -e UID=$(id -u) -e GID=$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt-t
        elif [ "$use_gpu" = "yes" ]; then
            sudo docker build -f install/Dockerfile-t -t mlt-t .
            sudo docker run --gpus all -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt-t
        else
            sudo docker build -f install/Dockerfile-t -t mlt-t .
            sudo docker run -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/tf -it --rm -p 8888:8888 mlt-t
        fi
    fi
fi

