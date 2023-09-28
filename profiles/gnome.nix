{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

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
    blur-my-shell # Blur when opening menu
    dash-to-dock # Pin dock
    gsconnect # Connect to phone
    just-perfection
    syncthing-indicator
    task-widget # Tasks
    vitals # Computer status
  ];

  # gsconnect required ports
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1716;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1716;
        to = 1764;
      }
    ];
  };
}
