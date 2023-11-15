# The Universal ML-Template

# Getting Started.
* Install docker and (optionally) setup OpenAI API keys, see [INSTALL.md](./INSTALL.md):
* Read about the philosophy behind this template at [PHILOSOPHY.md](./PHILOSOPHY.md)
* Classify some stuff quickly using examples found in the [examples](./examples/) folder.
* Use tensorflow or pytorch to create your own models... see the [./notebooks/README.md](./notebooks/README.md).
* OR make GPT-4 write your models for you... e.g. run the following:
  * ```bash build-docker-image.sh```
  * ```bash open-interpreter.sh```
  * then give open-interpreter a command and watch it go... for example ```create a dummy dataset of 10 statements often associated with republicans, democrats, libertarians and socialists then write me a deep neural network in pytorch using torchvision to classify those statements, write the training loop and also test the model on a new statement.```
  * Press ```CTRL-C``` to quit
