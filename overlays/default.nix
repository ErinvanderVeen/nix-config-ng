# This file defines overlays, the attributes from this file are added to the overlays in the flake.nix file.
{ ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    gnome-system-monitor = prev.gnome-system-monitor.overrideAttrs (_: _: {
      postInstall = ''
        rm $out/bin/gnome-system-monitor
        ln -s ${final.mission-center}/bin/missioncenter $out/bin/gnome-system-monitor
      '';
    });
  };
}
