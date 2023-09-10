{ config, lib, pkgs, user, ... }:
{
  home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
  home.file.".local/share/fcitx5/rime" = {
    source = builtins.fetchGit {
      url = https://git.26hz.com.cn/hertz/rime;
      rev = "16eb7c77cb186c3b8747e50cc733fd78bd057868";
    };
    recursive = true;
  };
}
