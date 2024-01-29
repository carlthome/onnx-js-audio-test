{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "onnx-js-audio-test";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    bun
    (python3.withPackages (ps: with ps; [
      torch
      onnx
    ]))
  ];

  # TODO Use buildNpmPackage instead so build dependencies are taken from the store.
  configurePhase = ''
    bun install
  '';

  buildPhase = ''
    # Bundle web app dependencies.
    bun build index.ts --outdir=dist --target=browser
    cp node_modules/onnxruntime-web/dist/*.wasm dist
    cp index.html dist

    # Include app entrypoint.
    mv run.sh onnx-js-audio-test
    chmod +x onnx-js-audio-test

    # Add model.onnx to dist.
    python main.py
    mv model.onnx dist
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r dist $out/bin
    cp onnx-js-audio-test $out/bin
  '';
}
