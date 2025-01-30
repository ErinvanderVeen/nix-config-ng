# This module contains all packages without much/any configuration.
{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./ghostty.nix
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

      # libreoffice-fresh
      endeavour # Google Task UI
    ];
    keyboard = null;
  };

  systemd.user.sessionVariables = {
    TERM = "ghostty";
  };

  xsession = {
    enable = true;
  };
}
