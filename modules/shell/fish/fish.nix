{ lib, pkgs, user, hostname, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      __fish_command_not_found_handler = {
        body = "echo Hei~ ${user}, COMMAND WAS NOT FOUND: $argv[1]\n/run/current-system/sw/bin/command-not-found $argv[1]";
        onEvent = "fish_command_not_found";
      };
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
    shellAliases = {
      gaa = "git add .";
      gcm = "git commit -m";
      gca = "git commit --amend -m";
      gpl = "git pull";
      gph = "git push";
      gco = "git checkout";
      gst = "git status";
      gg = "git log --pretty=format:'%C(auto)%h %ad | %C(auto)%s%d %Cblue(%an)' --graph --date=short";
      cdconf = "cd /home/${user}/Flakes/";
      nixupdate = "nix flake update";
      nixupgrade = "doas nixos-rebuild switch --flake .#hix";
      fars = "curl -F 'c=@-' 'https://fars.ee/' <";
    };
    loginShellInit = ''
      # set TTY1 (tty)
      # [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session sway --unsupported-gpu
       set TTY1 (tty)
       [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session Hyprland
    '';
  };
  home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
  home.file.".config/fish/functions/l.fish".text = import ./functions/l.nix;
  home.file.".config/fish/functions/n.fish".text = import ./functions/n.nix;
  home.file.".config/fish/functions/r.fish".text = import ./functions/r.nix;
  home.file.".config/fish/functions/ls.fish".text = import ./functions/ls.nix;
  home.file.".config/fish/functions/nf.fish".text = import ./functions/nf.nix;
  home.file.".config/fish/functions/vi.fish".text = import ./functions/vi.nix;
  home.file.".config/fish/functions/top.fish".text = import ./functions/top.nix;
  home.file.".config/fish/functions/owf.fish".text = import ./functions/owf.nix;
  home.file.".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
  home.file.".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
  home.file.".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
}
