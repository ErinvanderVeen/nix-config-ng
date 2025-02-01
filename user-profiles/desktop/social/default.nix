{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      vesktop # Custom client with support for screen sharing on Linux
      signal-desktop
    ];
  };
}
