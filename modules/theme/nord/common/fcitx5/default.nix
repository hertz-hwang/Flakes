{ config, lib, pkgs, user, ... }:
{
  home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".local/share/fcitx5/themes/Nord/arrow.png".source = ./arrow.png;
  home.file.".local/share/fcitx5/themes/Nord/radio.png".source = ./radio.png;
  home.file.".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
  home.file.".local/share/fcitx5/rime" = {
    source = builtins.fetchGit {
      url = https://git.26hz.com.cn/hertz/rime-tiger_code;
      rev = "f0563fe34fa1e024f624c11ad44c16ae3adedbab";
    };
    recursive = true;
  };
}
