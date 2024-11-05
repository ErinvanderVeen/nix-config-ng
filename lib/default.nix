{ inputs
, overlays
, outputs
, ...
}:
let
  mkUserInternal =
    { userName ? "nixos"
    , profiles ? [ ]
    ,
    }: {
      imports = inputs.nixpkgs.lib.lists.flatten [
        # Always load the home-manager module for this specific user
        (../user-profiles + "/${userName}.nix")
        {
          home.username = userName;
          home.homeDirectory = "/home/${userName}";
        }

        profiles
      ];
    };
in
rec {
  # Function to create a single NixOS system
  mkNixosSystem =
    { hardwareModules ? [ ]
    , users ? [ users.nixos ]
    , profiles ? [ ]
    , hostName ? "NixOS"
    , system ? "x86_64-linux"
    , rocmSupport ? false
    ,
    }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system rocmSupport;
        config.allowUnfree = true;
        overlays = [
          overlays.additions
          overlays.modifications
          inputs.nur.overlay
          inputs.nixgl.overlay
        ];
      };

      nixos-modules = map (a: ../modules + "/${a}") (builtins.attrNames (builtins.readDir ../modules));
    in
    inputs.nixpkgs.lib.nixosSystem rec {
      inherit system;
      inherit pkgs;
      specialArgs = { inherit inputs outputs; };
      modules = inputs.nixpkgs.lib.lists.flatten [
        nixos-modules
        inputs.home-manager.nixosModules.home-manager
        {
          networking.hostName = hostName;
          home-manager = {
            useGlobalPkgs = true;
            extraSpecialArgs = specialArgs;
          };
        }
        # These modules are taken directly from nixos-hardware's nixosModules
        hardwareModules

        # Always load the module for this specific hostname
        (../hosts + "/${hostName}")

        users
        profiles
      ];
    };

  mkHomeManager =
    { system ? "x86_64-linux"
    }: args: inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        (mkUserInternal args)
        {
          home.stateVersion = "24.11";
          targets.genericLinux.enable = true;
          programs.home-manager.enable = true;
        }
      ];
      extraSpecialArgs = { inherit inputs outputs; };
      pkgs = import inputs.nixpkgs {
        config.allowUnfree = true;
        overlays = [
          overlays.additions
          overlays.modifications
          inputs.nur.overlay
          inputs.nixgl.overlay
        ];
      };
    };

  # Function to create a single user
  mkUser =
    { userName ? "nixos"
    , profiles ? [ ]
    } @ args: {
      imports = inputs.nixpkgs.lib.lists.flatten [
        # Always load the NixOS module for this specific user
        (../users + "/${userName}")

        {
          home-manager.users.${userName} = mkUserInternal args;
        }
      ];
    };
}
