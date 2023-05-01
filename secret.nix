{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "secret";
  shellHook = ''
  '';
  nativeBuildInputs = with pkgs; [ openssl sops age ssh-to-age ssh-to-pgp ];
}
