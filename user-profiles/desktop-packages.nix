# This module contains all packages without much/any configuration.
{ pkgs, ... }:
{
  imports = [
    ./development-desktop-packages.nix
  ];

  home = {
    packages = with pkgs; [
      bitwarden-desktop
      celluloid
      element-desktop
      # libreoffice-fresh
      pinta
      standardnotes

      signal-desktop

      transmission_4-gtk
    ];
  };
}
