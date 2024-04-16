# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{ pkgs, inputs }: {
  hyprscroller = pkgs.unstable.hyprlandPlugins.mkHyprlandPlugin pkgs.hyprland {
    pluginName = "hyprscroller";
    version = "0.39.1";

    src = inputs.hyprscroller;

    installPhase = ''
      mkdir -p $out/lib/
      cp hyprscroller.so $out/lib/libhyprscroller.so
    '';

    dontStrip = true;

    nativeBuildInputs = with pkgs; [ cmake ];

    meta = with pkgs.lib; {
      homepage = "https://github.com/dawsers/hyprscroller";
      description = "Hyprland layout plugin providing a scrolling layout like PaperWM";
      license = licenses.mit;
      platforms = platforms.linux;
      maintainers = [ maintainers.erin ];
    };
  };
}
