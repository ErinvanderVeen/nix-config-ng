{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  fonts.packages = with pkgs; [
    inter
  ];

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-console
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      gnome-characters
    ]);

  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator # Sys tray
    vitals # Computer status
    paperwm # Scrolling WM
    valent
  ] ++ (with pkgs; [
    gnome-pomodoro
    valent
  ]);

  # valent required ports
  networking.firewall = rec {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
