{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "blog";
  shellHook = ''
    export PS1="\e[0;32m(Blog)\$ \e[m" 
    cd ./blog
  '';
  nativeBuildInputs = with pkgs; [ hugo ];
}
