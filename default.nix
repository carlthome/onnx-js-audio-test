{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  name = "onnx-js-audio-test";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    bun
    nodejs
    npmHooks.npmConfigHook
    (pkgs.python3.withPackages (ps: with ps; [
      torch
      onnx
    ]))
  ];

  npmDeps = pkgs.fetchNpmDeps {
    src = ./.;
    hash = "sha256-PQHsc3K2+Y+sAy/le3/0TPaigJN1jkQE/qIwPl38kPM=";
  };

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
