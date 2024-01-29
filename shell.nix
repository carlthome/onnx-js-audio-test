{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.mkShell {
  name = "bun";
  buildInputs = with pkgs; [
    nodejs
    bun
    nodePackages.typescript
    nodePackages.typescript-language-server
    (python3.withPackages (ps: with ps; [
      torch
      onnx
      onnxruntime
    ]))
  ];
}
