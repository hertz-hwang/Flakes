{ config, pkgs, user, inputs, ... }:

{
  imports =
    (import ../../../modules/hardware) ++
    (import ../../../modules/virtualisation) ++
    [
      ../hardware-configuration.nix
      ../../../modules/fonts
    ] ++ [
      # ../../../modules/desktop/sway
      ../../../modules/desktop/hyprland
    ];

  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$6$xLClr6zXQEwxMAH8$3g.csAWF.r0nV.rLZXJqV4OgfeeTEGq7MHJj6PRVDPFn/tgLkT3Lgy8.QBnLd2ycp95eNMvwyAWKdtmEKDpgb.";
  users.users.${user} = {
    initialHashedPassword = "$6$xKAMnU6Q1Cezug16$O6Q.UCmwM34tNSjxjKfR9PMUqt6YTyu4y5meZOaWTHU4mB8FGTnbIZ1KdX.9qCN/3PsdgRKeZK56/fyOPFcea0";
    # shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "podman" "libvirtd" "networkmanager" "video" "audio" ];
    packages = (with pkgs; [
      tdesktop
      qq
      thunderbird
      blender
      dbeaver
      aichat
      chatgpt-cli
      bili_tui
      pavucontrol
      libjack2
      jack2
      qjackctl
      jack2Full
      jack_capture
      pulseaudioFull
    ]) ++ (with config.nur.repos;[
      linyinfeng.icalingua-plus-plus
    ]);
  };
  boot = {
    supportedFilesystems = [ "ntfs" ];
    #supportedFilesystems = [ "zfs" "ntfs" ];
    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
      "amdgpu.dcfeaturemask=0x8"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-chinese-addons fcitx5-table-extra fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki ];
  };

  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
        "/etc/ssh"
        "/etc/NetworkManager/system-connections"
        #"/etc/v2raya"
        "/var/log"
        "/var/lib"
      ];
      files = [
        "/etc/machine-id"
      ];
      users.${user} = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".cache"
          "Workspace"
          ".npm-global"
          ".config"
          ".thunderbird"
          ".go-musicfox"
          "Flakes"
          "Kvm"
          ".cabal"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".local"
          ".mozilla"
        ];
        files = [
          ".npmrc"
        ];
      };
    };
    systemPackages = with pkgs; [
      libnotify
      wl-clipboard
      wlr-randr
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      pkgs.xorg.xeyes
      glfw-wayland
      xwayland
      pkgs.qt6.qtwayland
      cinnamon.nemo
      networkmanagerapplet
      wev
      wf-recorder
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      pkgs.rust-bin.stable.latest.default
      lxappearance
      imagemagick
      pkgs.sway-contrib.grimshot
      flameshot
      grim
    ];
  };

  services.xserver = {
    xkbOptions = "caps:escape";
  };
  console.useXkbConfig = true;

  services = {
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "${user}";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    extraConfig = ''
      ${user} ALL=(ALL) ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit keepenv nopass :wheel
    '';
  };
  #zramSwap.enable = true;
}
