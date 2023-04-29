{ config, lib, pkgs, user, ... }:
{
  home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
  home.file.".local/share/fcitx5/rime" = {
    source = builtins.fetchGit {
      url = https://git.26hz.com.cn/hertz/rime;
      rev = "891e5bb54245864936c3d95f7e0a9d4e51352ba4";
    };
    recursive = true;
  };
}
