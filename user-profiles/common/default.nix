{ pkgs, ... }: {

  imports = [
    ./shell.nix
    ./eza.nix
  ];

  home.packages = with pkgs; [
    bat
    bottom
    coreutils
    curl
    eza
    fd
    jq
    ripgrep
    skim
    tealdeer
    util-linux
  ];
}
