{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "blog";
  shellHook = ''
    cd ./blog
  '';
  nativeBuildInputs = with pkgs; [ hugo ];
}
