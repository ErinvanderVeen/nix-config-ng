{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = with pkgs; [ xterm ];
    };
  };

  # Allows starting terminal applications from GNOME
  xdg.terminal-exec.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome-tour
    gnome-characters
  ];
}
