# This module is reponsible for automatically keeping our NixOS machines up to date
{
  pkgs,
  lib,
  config,
  ...
}: {
  system.autoUpgrade = {
    enable = true;
    dates = "Sun";
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
