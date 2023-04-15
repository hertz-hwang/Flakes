{ config, lib, pkgs, ... }:

{
  services = {
    xserver.enable = true;
    xserver.videoDrivers = [ "amdgpu" ];
  };
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
	rocm-opencl-runtime
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    pulseaudio.support32Bit = true;
  };
  environment = {
    systemPackages = with pkgs; [
      glxinfo
    ];
  };
}
