# This module contains all packages without much/any configuration.
{ pkgs, inputs, ... }: {
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

      baobab
      blackbox-terminal
      celluloid
      element-desktop
      gnome-secrets
      keepassxc
      libreoffice-fresh
      pinta
      planify # Todoist GUI
      signal-desktop
      translate-shell
      transmission-gtk
    ];
    keyboard = null;

    sessionVariables = {
      TERM = "blackbox";
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        "browser.tabs.loadInBackground" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
      };
      userChrome = ''
        @import "${inputs.firefox-gnome-theme}/userChrome.css";
      '';
      userContent = ''
        @import "${inputs.firefox-gnome-theme}/userContent.css";
      '';
    };
  };
}
