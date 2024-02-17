{ pkgs, ... }: {
  home.packages = with pkgs; [
    gimp-with-plugins
    krita
    scribus
    upscayl
  ];
}
