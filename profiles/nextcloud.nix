{ pkgs, config, ... }:
{
  services.nextcloud = {
    enable = true;
    hostName = "Mordremoth.local";
    database.createLocally = true;
    config = {
      adminpassFile = "/etc/nextcloud-pass-file";
    };
    package = pkgs.nextcloud30;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        contacts
        calendar
        tasks
        maps
        memories
        music
        notes
        ;
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
