# onnx-js-audio-test

Ongoing experiment to see if we can use ONNX to run audio processing in the browser. This is a proof of concept, not a production-ready solution.

## Usage

### Install build environment

You can install Python and JavaScript dependencies however you'd like, but easiest is to use [direnv](https://direnv.net/) and [nix](https://nixos.org/) (with [flakes enabled](https://nixos.wiki/wiki/Flakes#Enable_flakes)), with which you can just run:

```sh
direnv allow
```

and go get a coffee while it installs everything you need.

### Create a ONNX model

The idea is that Python is used to create a model, which is then exported to ONNX, which is then loaded in the browser and run later. Thus first we need to create a model. An example is included as `main.py`. To run it, just run:

```sh
python main.py
```

This will output a model.onnx file.

### Create a browser app

The client-side browser app is created with Bun (but you can use whatever you want). To start a local web server with everything bundled, just run:

```sh
bun install

bun run local
```

And look in your browser console to see the model computation result. Hopefully it's the same as the Python result!
