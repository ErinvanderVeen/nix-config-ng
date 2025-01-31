{
  inputs,
  overlays,
  outputs,
  ...
}:
let
  mkUserInternal =
    {
      userName ? "nixos",
      profiles ? [ ],
    }:
    {
      imports = inputs.nixpkgs.lib.lists.flatten [
        # Always load the home-manager module for this specific user
        (../user-profiles + "/users/${userName}.nix")
        {
          home.username = userName;
          home.homeDirectory = "/home/${userName}";
        }

        (builtins.map collectLeafs profiles)
      ];
    };

  collectLeafs =
    subtree:
    if builtins.isAttrs subtree then
      let
        traverse =
          attrSet: acc:
          builtins.foldl' (
            accum: key:
            let
              val = attrSet.${key};
            in
            if builtins.isAttrs val then traverse val accum else accum ++ [ val ]
          ) acc (builtins.attrNames attrSet);
      in
      traverse subtree [ ]
    else
      [ subtree ];
in
rec {
  # Function to create a single NixOS system
  mkNixosSystem =
    {
      hardwareModules ? [ ],
      users ? [ users.nixos ],
      profiles ? [ ],
      hostName ? "NixOS",
      system ? "x86_64-linux",
      rocmSupport ? false,
    }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system rocmSupport;
        config.allowUnfree = true;
        overlays = [
          overlays.additions
          overlays.modifications
          inputs.nur.overlays.default
          inputs.nixgl.overlay
        ];
      };

    in
    # nixos-modules = map (a: ../modules + "/${a}") (builtins.attrNames (builtins.readDir ../modules));
    inputs.nixpkgs.lib.nixosSystem rec {
      inherit system;
      inherit pkgs;
      specialArgs = {
        inherit inputs outputs;
        tyriaLib = import ./tyria.nix { inherit pkgs; };
      };
      modules = inputs.nixpkgs.lib.lists.flatten [
        # nixos-modules
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
        (builtins.map collectLeafs profiles)
      ];
    };

  mkHomeManager =
    {
      system ? "x86_64-linux",
    }:
    args:
    inputs.home-manager.lib.homeManagerConfiguration rec {
      modules = [
        (mkUserInternal args)
        {
          home.stateVersion = "24.11";
          targets.genericLinux.enable = true;
          programs.home-manager.enable = true;
        }
      ];
      extraSpecialArgs = {
        inherit inputs outputs;
        tyriaLib = import ./tyria.nix { inherit pkgs; };
      };
      pkgs = import inputs.nixpkgs {
        config.allowUnfree = true;
        overlays = [
          overlays.additions
          overlays.modifications
          inputs.nur.overlays.default
          inputs.nixgl.overlay
        ];
      };
    };

  # Function to create a single user
  mkUser =
    {
      userName ? "nixos",
      profiles ? [ ],
    }@args:
    {
      imports = inputs.nixpkgs.lib.lists.flatten [
        # Always load the NixOS module for this specific user
        (../users + "/${userName}")

        {
          home-manager.users.${userName} = mkUserInternal args;
        }
      ];
    };

  createProfiles =
    dir:
    let
      files = builtins.readDir dir;
      sanitizeName = name: inputs.nixpkgs.lib.strings.removeSuffix ".nix" name;
      mapEntry =
        name: type:
        let
          cleanName = sanitizeName name;
        in
        if type == "directory" then
          { ${cleanName} = createProfiles (dir + "/${name}"); }
        else
          { ${cleanName} = dir + "/${name}"; };
    in
    builtins.foldl' (acc: name: acc // mapEntry name files.${name}) { } (builtins.attrNames files);
}
