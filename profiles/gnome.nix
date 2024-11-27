{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-console
      gnome-tour
      gnome-characters
    ]
  );

  environment.systemPackages = with pkgs; [
    gnome-pomodoro
  ];

  # valent required ports
  # networking.firewall = rec {
  #   allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
  #   allowedUDPPortRanges = allowedTCPPortRanges;
  # };
}
