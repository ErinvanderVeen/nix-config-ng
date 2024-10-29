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
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nixos-hardware
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      # I purposefully do not support darwin or 32 bit
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ];

      createProfiles = dir: builtins.listToAttrs (map
        (a: {
          name = nixpkgs.lib.strings.removeSuffix ".nix" a;
          value = dir + "/${a}";
        })
        (builtins.attrNames (builtins.readDir dir)));

      profiles = createProfiles ./profiles;
      user-profiles = createProfiles ./user-profiles;

      overlays = import ./overlays {
        inherit inputs;
      };

      # Custom library that I use to create users and nixosSystems
      tyriaLib = import ./lib { inherit inputs overlays outputs; };

      users = {
        erin = tyriaLib.mkUser {
          userName = "erin";
          profiles = with user-profiles; [
            bat
            common
            dconf
            desktop-packages
            direnv
            discord
            git
            github
            helix
            lazygit
            lutris
            ssh
            syncthing
            terminal-packages
          ];
        };

        nixos = tyriaLib.mkUser {
          userName = "nixos";
          profiles = with user-profiles; [
            common
            git
            helix
            lazygit
            ssh
          ];
        };

        media = tyriaLib.mkUser {
          userName = "media";
          profiles = with user-profiles; [
            common
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
            protonvpn
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
            common
            corectrl
            # home-assistant
            jellyfin
            media-group
            minecraft
            # protonvpn
            # protonvpn-headless
            samba
            syncthing
            syncthing-ports
            transmission
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
            common
            gnome
            ollama
            protonvpn
            update
          ];
        };
      };

      # TODO: Right now, home configurations are handled through the NixOS home-manager modules
      homeConfigurations = { };
    };
}
