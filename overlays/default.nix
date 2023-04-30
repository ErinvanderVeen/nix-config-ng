# This file defines overlays, the attributes from this file are added to the overlays in the flake.nix file.
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # These packages, we want to get from unstable
    inherit
      (final.unstable)
      discord
      element-desktop
      helix
      ;
  };

  # Allows pkgs.unstable.X
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
