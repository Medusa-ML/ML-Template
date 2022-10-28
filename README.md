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

# Frequently Asked Questions

### Will this run on Windows or macOS?

Yes, but you need to install docker first, see link above. 

### How to I shut down the notebook?

Go to the terminal where you ran the ```run-training....sh``` and press ```CTRL+C```, [WTF](https://medium.com/@aantipov/what-happens-when-you-ctrl-c-in-the-terminal-36b093443e06)

### Can I deploy this in a cloud environment via Docker? or run it on my big ML rig with many nvidia GPUs?

Hell yes you can! I'll eventually write a more detailed guide here on how to do that, but the setup is almost identical to running locally.
