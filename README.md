# medusa-ml-template

a template project for machine learning experiments, using dockerized tensorflow environments and data downloaders

# Requirements

* [docker](https://www.docker.com/)
* a bash shell

# Getting Started

* start your training environment by running ```sh run-training-environment.sh``` or ```sh run-training-environment-w-gpu.sh``` and follow the link to the jupyter server
* Use a [downloader](./downloader/) to download a dataset into the [data](./data/) folder
* Run a [training notebook](./training_notebooks) to fit your model
* Export your model to the [saved models](./saved_models) folder
* Shrink, optimize, and deploy your model, see [deploy](./deploy) for examples 
