{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "blog";
  shellHook = ''
    export PS1="\e[0;32m(Blog)\$ \e[m" 
    cd ./blog
    cp -r ./static/zev ./themes/
    #hugo server --buildDrafts --forceSyncStatic
  '';
  nativeBuildInputs = with pkgs; [ hugo ];
}
