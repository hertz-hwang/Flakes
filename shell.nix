{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  shellHook = ''
          echo "
     ______   _           _                 
    |  ____| | |         | |                
    | |__    | |   __ _  | | __   ___   ___ 
    |  __|   | |  / _\` | | |/ /  / _ \ / __|
    | |      | | | (_| | |   <  |  __/ \\__ \\
    |_|      |_|  \__,_| |_|\_\  \___| |___/
          "
  '';
  nativeBuildInputs = with pkgs; [ git nix-prefetch-git nix-prefetch-scripts neovim ];
}
