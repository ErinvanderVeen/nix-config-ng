{ pkgs
, ...
}: {
  imports = [
    ./cachix.nix
    ./direnv.nix
    ./nix.nix
    ./sound.nix
    ./shell.nix
    ./networking.nix
    ./locale.nix
  ];

  environment = {
    variables = {
      # Set a decent default editor
      EDITOR = "hx";
      NIX_AUTO_RUN = "1";
    };

    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      bat
      bottom
      coreutils
      curl
      eza
      fd
      fzf
      git
      helix
      jq
      ripgrep
      skim
      tealdeer
      utillinux
    ];
  };

  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = true;
  };

  # Service that makes Out of Memory Killer more effective
  services = {
    earlyoom.enable = true;
    fwupd.enable = true;
  };
}
