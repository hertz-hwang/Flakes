{ lib, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = true;
        format = ''
          ╔═ ❄️ $shlvl$shell$username$hostname$nix_shell$directory$git_branch$git_commit$git_state$git_status$golang$jobs$cmd_duration
          ╚═ $character
        '';
        shlvl = {
          disabled = false;
          symbol = "ﰬ";
          style = "red bold";
        };
        shell = {
          disabled = false;
          format = "$indicator";
          fish_indicator = "";
          bash_indicator = "[BASH](white) ";
          #zsh_indicator = "";
        };
        username = {
          style_user = "white bold";
          style_root = "red bold";
          format = "[$user]($style)";
          disabled = false;
          show_always = true;
        };
        hostname = {
          format = "[$ssh_symbol](bold blue) on [$hostname](bold red) ";
          style = "green bold";
          disabled = false;
          ssh_only = false;
        };
        nix_shell = {
          symbol = " ";
          format = "[$symbol$name]($style) ";
          style = "purple bold";
        };
        git_branch = {
          only_attached = true;
          format = "$symbol[$branch]($style) ";
          symbol = "שׂ ";
          style = "yellow bold";
        };
        git_commit = {
          only_detached = true;
          format = "[ﰖ$hash]($style) ";
          style = "yellow bold";
        };
        git_state = {
          format = "[($state( $progress_current of $progress_total))]($style) ";
          cherry_pick = "[🍒 PICKING](bold red)";
          style = "purple bold";
        };
        git_status = {
          ##conflicted = "🏳";
          ##ahead = "🏎💨";
          ##behind = "😰";
          ##diverged = "😵";
          ##up_to_date = "✓";
          ##untracked = "🤷";
          ##stashed = "📦";
          ##modified = "📝";
          ##staged = "[++($count)](green)";
          ##renamed = "👅";
          ##deleted = "🗑 ";
          ##style = "green bold";
          disabled = false;
          ignore_submodules = false;
          ahead = "⇡";
          behind = "⇣";
          diverged = "⇕";
          conflicted = "=";
          deleted = "✘";
          format = "([\\[$all_status$ahead_behind\\]]($style) )";
          style = "green bold";
          modified = "!";
          renamed = "»";
          staged = "[++($count)](green)";
          stashed = "\\$";
          untracked = "?";
          up_to_date = "✓";
        };
        golang = {
          #format = "via [$version](bold cyan) ";
          #version_format = "v [$raw]";
          symbol = " ";
          #detect_extensions = "go";
          #detect_files = "['go.mod', 'go.sum', 'go.work', 'glide.yaml', 'Gopkg.yml', 'Gopkg.lock', '.go-version']";
          #detect_folders = "['Godeps']";
          #style = "'bold cyan'";
          disabled = false;
        };
        directory = {
          read_only = " ";
          truncation_length = 5;
        };
        cmd_duration = {
          format = "[$duration]($style) ";
          style = "blue";
        };
        jobs = {
          style = "green bold";
        };
        character = {
          success_symbol = "[λ](green bold)";
          error_symbol = "[λ](red bold)";
        };
      };
    };
  };
}
