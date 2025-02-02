{
  pkgs,
  config,
  ...
}:
{
  services.nextcloud = {
    enable = true;
    hostName = "Mordremoth.local";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "/etc/nextcloud-pass-file";
    };
    package = pkgs.nextcloud30;
    appstoreEnable = false;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        contacts
        calendar
        tasks
        maps
        music
        notes
        ;
    };
  };

  environment.systemPackages = [
    config.services.nextcloud.occ
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
