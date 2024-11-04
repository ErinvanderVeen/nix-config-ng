{ pkgs, ... }:
{
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = appindicator; } # Sys tray
      { package = vitals; } # Computer status
      { package = paperwm; } # Scrolling WM
    ];
  };
}
