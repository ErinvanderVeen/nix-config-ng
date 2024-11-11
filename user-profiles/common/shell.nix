{ pkgs, ... }: {
  home.shellAliases = {
    grep = "rg";

    # nix
    n = "nix";
    nepl = "nix repl nixpkgs";
    top = "btm";
    htop = "btm";

    # cat
    cat = "bat";
  };

  # Bash is enabled to have shell completion and other things.
  # Generally, try to avoid bash.
  programs.bash.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';
    plugins = with pkgs.fishPlugins; [
      (with done; { inherit name src; })
    ];
  };
}
