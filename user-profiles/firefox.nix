{ inputs, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        # "gnomeTheme.hideSingleTab" = true;
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
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ecosia
        proton-pass
        simple-translate
        sponsorblock
        ublock-origin
      ];
      search = {
        force = true;
        order = [ "Ecosia" "DuckDuckGo" ];
        engines = {
          "Ecosia" = {
            urls = [{
              template = "https://www.ecosia.org/search?q={searchTerms}";
            }];
            iconUpdateURL = "https://www.ecosia.org/static/icons/favicon.ico";
            definedAliases = [ "@eco" ];
          };
        };
      };
    };
  };
}
