# medusa-ml-template

a template project for machine learning experiments, using dockerized pytorch environments and data downloaders

# TODO
* [ ] Update [pytorch docker image](https://pytorch.org/docs/stable/dynamo/installation.html#docker-installation)
* [ ] jupyter setup guide
* [ ] Integrate [Joe R Playlist examples](https://learning.oreilly.com/playlists/024a3344-fa6d-45ec-92b3-e8495765ed1b)
* [ ] [LoRa fine tuning example](https://github.com/tloen/alpaca-lora)

# Requirements

* [docker](https://www.docker.com/)
* a bash shell

# Optional Dependencies
* for GPU users [nvidia container toolkit](https://github.com/NVIDIA/nvidia-container-toolkit)

# Getting Started

* Build the docker image by using ```sh build-docker-image.sh```
* start your training environment by running ```sh run-training-environment.sh``` or ```sh gpu-environment.sh``` and follow the link to the jupyter server
* Use a [downloader](./downloader/) to download a dataset into the [data](./data/) folder
* Run a [training notebook](./training_notebooks) to fit your model
* Export your model to the [saved models](./saved_models) folder
* Shrink, optimize, and deploy your model, see [deploy](./deploy) for examples 

# Frequently Asked Questions

### Will this run on Windows or macOS?

Not really, but you can try if you must.

### How to I shut down the notebook?

Go to the terminal where you ran the ```run-training....sh``` and press ```CTRL+C```, [WTF](https://medium.com/@aantipov/what-happens-when-you-ctrl-c-in-the-terminal-36b093443e06)

### What the hell is this notebook stuff?

Try this tutorial to learn more [tutorial](https://jupyter.org/try)

### Can I deploy this in a cloud environment via Docker? or run it on my big ML rig with many nvidia GPUs?

Hell yes you can! I'll eventually write a more detailed guide here on how to do that, but the setup is almost identical to running locally.
