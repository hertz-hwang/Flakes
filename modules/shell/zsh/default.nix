{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    completionInit = "autoload -U compinit && compinit";
    enableVteIntegration = true;
    #cdpath = [];
    defaultKeymap = "emacs";
    dirHashes = {
      docs = "$HOME/Documents";
      vids = "$HOME/Videos";
      dl = "$HOME/Downloads";
    };
    dotDir = ".config/zsh";
    #envExtra = ""; #Extra commands that should be added to .zshenv
    initExtra = ''
      eval "$(zoxide init zsh)"
      source ~/.config/zsh/fzf.zsh
      backward-kill-dir () {
      local WORDCHARS='~!#$%^&*(){}[]<>?+;'
        zle backward-kill-word
        zle -f kill
      }
      zle -N backward-kill-dir
      bindkey '^[^?' backward-kill-dir

      backward-word-dir () {
        local WORDCHARS='~!#$%^&*(){}[]<>?+;'
        zle backward-word
      }
      zle -N backward-word-dir
      bindkey "^[[1;3D" backward-word-dir

      forward-word-dir () {
        local WORDCHARS='~!#$%^&*(){}[]<>?+;'
        zle forward-word
      }
      zle -N forward-word-dir
      bindkey "^[[1;3C" forward-word-dir

      [[ -e /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
      source ~/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh
    ''; #Extra commands that should be added to .zshrc
    #localVariables = {};
    #loginExtra = {};
    #logoutExtra = {};
    #profileExtra = {};
    #sessionVariables = { MAILCHECK = 30; };
    shellAliases = {
      n = "neofetch";
      ls = "eza --icons";
      ll = "eza --icons -l";
      la = "eza --icons -a";
      l = "eza --icons -alhF";
      tl = "tldr";
      weather = "curl 'wttr.in/fuzhou?0m&lang=zh'";
      fars = "curl -F ' c=@-' 'https://fars.ee/' <";
      myip = "curl http://ipecho.net/plain; echo";
      server = "python3 -m http.server 8080";
      find = "fd --exclude ~/.cache";
      cat = "bat";
      grep = "rg";
      sed = "sd";
      ytd = "yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 ";
      df = "duf";
      cd = "z";
      dh = "df -h -x fuse --output=source,fstype,size,pcent,target";
      gaa = "git add .";
      gcm = "git commit -m";
      gca = "git commit --amend";
      gpl = "git pull";
      gph = "git push";
      gco = "git checkout";
      gst = "git status";
      gg = "git log --pretty=format:'%C(auto)%h %ad | %C(auto)%s%d %Cblue(%an)' --graph --date=format:'%Y-%m-%d %H:%M:%S[%z]'";
    };
    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "cf318e06a9b7c9f2219d78f41b46fa6e06011fd9";
          sha256 = "sha256-RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "c2b4aa5ad2532cca91f23908ac7f00efb7ff09c9";
          sha256 = "sha256-gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
        };
      }
      {
        name = "powerlevel10k";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "873c4ff09c559a507d33e528df7e27a8a48705d7";
          sha256 = "sha256-GHHoV9RfokusOKUjQ7yaxwENdM82l1qHiebs1AboMfY=";
        };
      }
    ];
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.config/zsh/history";
    };
  };
  home.file = {
    ".config/zsh/fzf.zsh" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink ./fzf.zsh;
    };
    ".config/zsh/p10k.zsh" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink ./p10k.zsh;
    };
    ".config/zsh/file_preview.sh" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink ./file_preview.sh;
    };
    ".config/zsh/img_preview.sh" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink ./img_preview.sh;
    };
  };
}
