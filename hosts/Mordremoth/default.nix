{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  services.xserver.displayManager.autoLogin.user = "erin";

  # Data location for some services
  services.syncthing.dataDir = "/var/nas-data/syncthing";
  services.transmission.settings = {
    download-dir = "/var/nas-data/media/complete";
    incomplete-dir = "/var/nas-data/media/incomplete";
  };

  system.stateVersion = "22.11";
}
