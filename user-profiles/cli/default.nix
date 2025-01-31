{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bottom
    coreutils
    curl
    fd
    jq
    nix-output-monitor
    ripgrep
    tealdeer
    util-linux
  ];
}
