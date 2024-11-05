{ pkgs, ... }:
{
  home.packages = with pkgs.gnome; [
  ] ++
  (with pkgs; [
    geary
    gnome-contacts
    evolution-data-server
    gnome-system-monitor
  ]);

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = appindicator; } # Sys tray
      { package = vitals; } # Computer status
      { package = paperwm; } # Scrolling WM
    ];
  };
}
