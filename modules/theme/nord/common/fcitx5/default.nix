{ config, lib, pkgs, user, ... }:
{
  home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
  #home.file.".local/share/fcitx5/rime" = {
  #  source = ./_user-data;
  #  recursive = true;
  #};
}
