{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "secret";
  shellHook = ''
    export PS1="\e[0;31m(Secret)\$ \e[m" 
  '';
  nativeBuildInputs = with pkgs; [ sops age ssh-to-age ssh-to-pgp ];
}
