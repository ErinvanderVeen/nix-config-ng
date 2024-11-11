{
  # We always want fish, even when root, so we install it outside of home-manager
  programs.fish = {
    enable = true;
  };
}
