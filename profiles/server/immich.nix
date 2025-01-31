{ lib, ... }:
{
  # Hardware encoding
  systemd.services."immich-server".serviceConfig.PrivateDevices = lib.mkForce false;
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  services.immich = {
    host = "Mordremoth.local";
    enable = true;
    openFirewall = true;
    machine-learning = {
      enable = true;
    };
  };
}
