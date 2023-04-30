{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.interfaces.eno1.useDHCP = true;

  services.xserver.displayManager.autoLogin.user = "erin";

  system.stateVersion = "21.11";
}
