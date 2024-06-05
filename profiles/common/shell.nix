{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
  };

  environment.shellAliases = {
    grep = "rg";

    # nix
    n = "nix";
    nepl = "n repl nixpkgs";
    top = "btm";
    htop = "btm";

    # cat
    cat = "bat";
  };

}
