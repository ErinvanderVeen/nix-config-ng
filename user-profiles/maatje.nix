{ pkgs, ... }: {
  home.packages = with pkgs; [
    gimp-with-plugins
    krita
    r2modman # Modmanager for games, notably outward
    scribus
    spotify
    upscayl
  ];
}
