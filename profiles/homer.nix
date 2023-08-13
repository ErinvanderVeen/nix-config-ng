{config, ...}: let
  configuration = {
    title = config.networking.hostName;
    services = [
      {
        items = [
          {
            name = "Jellyfin";
            url = "http://${config.networking.hostName}.local:8096";
          }
        ];
      }
    ];
  };

  homer = config.nur.repos.dukzcry.homer.override {
    inherit configuration;
  };
in {
  services.nginx = {
    enable = true;

    virtualHosts."${config.networking.hostName}.local" = {
      locations."/" = {
        root = "${homer}/assets/config.yml";
      };
    };
  };
}
