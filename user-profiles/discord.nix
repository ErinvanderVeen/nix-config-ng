{ pkgs, ... }:
{
  home = {
    # Custom client with support for screen sharing on Linux
    packages = [ pkgs.vesktop ];
  };
}
