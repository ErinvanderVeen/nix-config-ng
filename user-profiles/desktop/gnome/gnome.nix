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
    # Remember to also update the dconf rules in ./dconf.nix
    extensions = with pkgs.gnomeExtensions; [
      { package = blur-my-shell; }
      { package = dash-to-dock; }
    ];
  };
}
