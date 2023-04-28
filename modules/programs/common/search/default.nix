{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      fd
      bat
      (ripgrep.override { withPCRE2 = true; })
    ];
  };
  programs = {
    fzf.enable = true;
  };
}
