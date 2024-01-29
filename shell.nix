{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.mkShell {
  name = "bun";
  buildInputs = with pkgs; [
    nodejs
    bun
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}
