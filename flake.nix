{
  description = "Erin's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    nur.url = "github:nix-community/NUR";

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      # I purposefully do not support darwin or 32 bit
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ];

      overlays = import ./overlays {
        inherit inputs;
      };

      # Custom library that I use to create users and nixosSystems
      tyriaLib = import ./lib { inherit inputs overlays outputs; };

      profiles = tyriaLib.createProfiles ./profiles;
      user-profiles = tyriaLib.createProfiles ./user-profiles;

      users = {
        erin = tyriaLib.mkUser {
          userName = "erin";
          profiles = with user-profiles; [
            cli
            core
            desktop
          ];
        };

        nixos = tyriaLib.mkUser {
          userName = "nixos";
          profiles = with user-profiles; [
            core
          ];
        };

        media = tyriaLib.mkUser {
          userName = "media";
          profiles = with user-profiles; [
            core
          ];
        };
      };
    in
    {
      # Custom packages
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./pkgs { inherit pkgs; }
      );

      # Exporting overlays for use whenever
      inherit overlays;

      # Custom modules TODO (maybe)
      # nixosModules = nixos-modules;
      # homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        Gwen = tyriaLib.mkNixosSystem {
          hostName = "Gwen";
          hardwareModules = with nixos-hardware.nixosModules; [
            common-cpu-intel
            common-gpu-amd
            common-pc
            common-pc-ssd
          ];
          users = with users; [
            erin
          ];
          profiles = with profiles; [
            common
            gnome
            steam
            update
          ];
        };

        Mordremoth = tyriaLib.mkNixosSystem {
          hostName = "Mordremoth";
          hardwareModules = with nixos-hardware.nixosModules; [
            common-cpu-intel
            common-pc
            common-pc-ssd
          ];
          users = with users; [
            nixos
            media
          ];
          profiles = with profiles; [
            core
            mullvad
            server
            update
          ];
        };

        Trahearne = tyriaLib.mkNixosSystem {
          hostName = "Trahearne";
          rocmSupport = true;
          hardwareModules = with nixos-hardware.nixosModules; [
            common-cpu-intel
            common-gpu-amd
            common-pc
            common-pc-ssd
          ];
          users = with users; [
            erin
          ];
          profiles = with profiles; [
            core
            gnome
            mullvad
            steam
            update
          ];
        };
      };

      homeConfigurations = {
        erin-development = tyriaLib.mkHomeManager { system = "x86_64-linux"; } {
          userName = "erin";
          profiles = with user-profiles; [
            core
            cli
            desktop.core
            desktop.gnome
            nixgl
          ];
        };
      };
    };
}
