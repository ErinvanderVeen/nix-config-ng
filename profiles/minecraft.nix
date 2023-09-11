{
  lib,
  pkgs,
  ...
}: {
  services.minecraft-server = {
    jvmOpts = "-Xmx6G -Xms6G";
    enable = true;
    eula = true;
    declarative = false;
    package = pkgs.unstable.papermc;
    serverProperties = {
      motd = "Minecraft's Mighty Four";
    };
    openFirewall = true;
  };

  # DO not automatically start the server
  systemd.services.minecraft-server.wantedBy = lib.mkForce [];
}
