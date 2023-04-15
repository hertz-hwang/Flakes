{ config, pkgs, user, ... }:

{
  virtualisation = {
    docker.enable = false;
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.groups.podman.members = [ "${user}" ];

  environment.systemPackages = with pkgs; [
    arion
    docker-client
    podman-compose
  ];
}
