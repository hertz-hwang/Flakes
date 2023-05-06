{ config, pkgs, ... }:
{
  programs = {
    btop = {
      settings = {
        color_theme = "nord";
      };
    };
  };
  home.file.".config/btop/themes/catppuccin_latte.theme".source = ./theme.nix;
}
