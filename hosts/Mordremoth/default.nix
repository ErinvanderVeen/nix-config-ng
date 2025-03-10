{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable hybrid soft/hardware encoding for VP8 and VP9.
  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  # };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  services.displayManager.autoLogin.user = "media";

  # Data location for some services
  services.syncthing.dataDir = "/var/nas-data/syncthing";
  services.transmission.settings = {
    download-dir = "/var/nas-data/media/complete";
    incomplete-dir = "/var/nas-data/media/incomplete";
  };
  services.immich.mediaLocation = "/var/nas-data/immich";
  services.minecraft-server.dataDir = "/var/nas-data/minecraft";
  services.nextcloud.home = "/var/nas-data/nextcloud";
  services.samba.settings = {
    media = {
      path = "/var/nas-data/media/";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "media";
      "force group" = "media";
    };
    # nextcloud = {
    #   path = "/var/nas-data/nextcloud/";
    #   browseable = "yes";
    #   "read only" = "no";
    #   "guest ok" = "no";
    #   "create mask" = "0644";
    #   "directory mask" = "0755";
    #   "force user" = "media";
    #   "force group" = "media";
    # };
    minecraft = {
      path = "/var/nas-data/minecraft/";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "minecraft";
      "force group" = "minecraft";
    };
  };

  nix.settings.trusted-users = [ "media" ];

  system.stateVersion = "22.11";
}
