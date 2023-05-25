# This module is reponsible for automatically keeping our NixOS machines up to date
{lib, ...}: {
  system.autoUpgrade = {
    enable = true;
    randomizedDelaySec = "10min";
    # Override for our servers
    allowReboot = lib.mkDefault false;
    flags = [];
    flake = "github:ErinvanderVeen/nix-config-ng";
  };

  environment.shellAliases = {
    nixos-update = "sudo nixos-rebuild switch --flake github:ErinvanderVeen/nix-config-ng";
  };
}
