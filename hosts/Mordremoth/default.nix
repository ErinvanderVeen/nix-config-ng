{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable hybrid soft/hardware encoding for VP8 and VP9.
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  services.xserver.displayManager.autoLogin.user = "media";

  # Data location for some services
  services.syncthing.dataDir = "/var/nas-data/syncthing";
  services.transmission.settings = {
    download-dir = "/var/nas-data/media/series";
    incomplete-dir = "/var/nas-data/media/incomplete";
  };

  nix.settings.trusted-users = ["media"];

  system.stateVersion = "22.11";
}
