{ config, lib, pkgs, user, ... }:
{
  home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
  home.file.".local/share/fcitx5/rime" = {
    source = builtins.fetchGit {
      url = https://git.26hz.com.cn/hertz/rime;
      rev = "3523371ba06c3e1311da787b48762371b0848bdd";
    };
    recursive = true;
  };
}
