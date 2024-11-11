{ pkgs, ... }: {

  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./git.nix
    ./helix.nix
    ./lazygit.nix
    ./shell.nix
    ./skim.nix
    ./ssh.nix
  ];

  home.packages = with pkgs; [
    bat
    bottom
    coreutils
    curl
    eza
    fd
    jq
    nix-output-monitor
    ripgrep
    skim
    tealdeer
    util-linux
  ];
}
