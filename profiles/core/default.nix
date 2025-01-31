{
  pkgs,
  ...
}:
{
  hardware.keyboard.zsa.enable = true;

  environment = {
    variables = {
      # Set a decent default editor
      EDITOR = "hx";
      NIX_AUTO_RUN = "1";
    };

    # Selection of sysadmin tools that can come in handy. Many of these are
    # duplicated in the user-profiles section. The reason for this is that we
    # want them to be available to every users on a NixOS system, and at least
    # also the home-manager user on a home-manager install.
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
      util-linux
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
