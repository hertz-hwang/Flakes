{ config, pkgs, ... }:

{
  programs = {
    obs-studio.enable = true;
    obs-studio.plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
  };
  home.file.".config/obs-studio/themes".source = ./themes;
}
