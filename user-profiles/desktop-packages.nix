# This module contains all packages without much/any configuration.
{ pkgs, ... }:
{
  imports = [
    ./development-desktop-packages.nix
    ./gtk.nix
  ];

  home = {
    packages = with pkgs; [
      alpaca
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
