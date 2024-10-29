{
  nix = {
    # Improve nix store disk usage
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      # Give root user and wheel group special Nix privileges.
      trusted-users = [ "root" "@wheel" ];

      # Improve nix store disk usage
      auto-optimise-store = true;
    };

    # Generally useful nix option defaults
    extraOptions = ''
      min-free = 536870912
      keep-outputs = false
      keep-derivations = false
      fallback = true
    '';
  };
}
