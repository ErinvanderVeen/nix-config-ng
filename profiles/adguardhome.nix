{...}: {
  services.adguardhome = {
    enable = true;
    mutableSettings = true;
    openFirewall = true;
    settings.bind_port = 3000;
  };
}
