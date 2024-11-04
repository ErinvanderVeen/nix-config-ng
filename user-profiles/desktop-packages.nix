# This module contains all packages without much/any configuration.
{ pkgs, ... }: {
  imports = [
    ./development-desktop-packages.nix
  ];

  home = {
    packages = with pkgs; [
      celluloid
      element-desktop
      keepassxc
      libreoffice-fresh
      pinta
      protonmail-desktop
      standardnotes

      signal-desktop

      transmission_4-gtk
    ];
  };
}
