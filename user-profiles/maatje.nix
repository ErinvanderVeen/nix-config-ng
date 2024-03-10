{ pkgs, ... }: {
  home.packages = with pkgs; [
    gimp-with-plugins
    krita
    scribus
    upscayl
    r2modman # Modmanager for games, notably outward
  ];
}
