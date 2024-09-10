# This module contains all packages without much/any configuration.
{ pkgs, ... }: {
  imports = [
    ./firefox.nix
  ];

  home = {
    packages = with pkgs; [
      # SPELLING
      aspell
      aspellDicts.en
      aspellDicts.nl
      aspellDicts.sv

      hunspell
      hunspellDicts.en_GB-ise
      hunspellDicts.en_US
      hunspellDicts.sv_SE
      hunspellDicts.nl_NL

      blackbox-terminal
      celluloid
      element-desktop
      keepassxc
      libreoffice-fresh
      pinta
      planify # Todoist GUI
      protonmail-desktop
      standardnotes

      signal-desktop
      telegram-desktop

      transmission_4-gtk
    ];
    keyboard = null;
  };

  systemd.user.sessionVariables = {
    TERM = "blackbox";
  };

  xsession = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };
}
