{ pkgs, ... }:
{
  home.packages = with pkgs; [
    geary
    gnome-contacts
    evolution-data-server
    gnome-system-monitor
  ];

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = appindicator; } # Sys tray
    ];
  };
}
