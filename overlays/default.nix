# This file defines overlays, the attributes from this file are added to the overlays in the flake.nix file.
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    # These packages, we want to get from unstable
    inherit
      (final.unstable)
      blackbox-terminal
      discord
      element-desktop
      helix
      protonvpn-gui
      signal-desktop
      flare-signal
      ;

    # helix-gpt's timeout is toooo little, increase it
    helix-gpt = final.unstable.helix-gpt.overrideAttrs (finalAttrs: previousAttrs: {
      prePatch = ''
        substituteInPlace src/models/api.ts \
            --replace 'timeout: number = 10000' 'timeout: number = 60000'
      '';
    });
  };

  # Allows pkgs.unstable.X
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "openssl-1.1.1w"
        ];
      };
    };
  };
}
