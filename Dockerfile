# Start from a PyTorch base image with GPU support
FROM pytorch/pytorch:latest
# if you want to use tensorflow change above to
#FROM tensorflow/tensorflow:latest


# Update the system and install necessary software
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install -y \
    python3-pip \
    gosu \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter Notebook and other useful stuff.
RUN pip install \
	jupyter \
	torchtext \
	scikit-llm \
	matplotlib 

# Set up the working directory
WORKDIR /workspace

# Change the ownership and permissions of /.local and other directories
RUN mkdir /.local /.jupyter /.config
RUN chmod -R 777 /.local /.config /.jupyter /workspace

# Copy the entrypoint script and give execute permission
# the lines below are safe to remove if you are not using open-interpreter
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# When the container launches, start a Jupyter Notebook server
CMD ["jupyter", "notebook", "--ip='*'", "--port=8888", "--no-browser"]

