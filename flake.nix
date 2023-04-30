{
  description = "Erin's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # I purposefully do not support darwin
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];

    # TODO: Abstract
    profiles = builtins.listToAttrs (map (a: {
      name = nixpkgs.lib.strings.removeSuffix ".nix" a;
      value = ./profiles + "/${a}";
    }) (builtins.attrNames (builtins.readDir ./profiles)));

    # TODO: Abstract
    user-profiles = builtins.listToAttrs (map (a: {
      name = nixpkgs.lib.strings.removeSuffix ".nix" a;
      value = ./user-profiles + "/${a}";
    }) (builtins.attrNames (builtins.readDir ./user-profiles)));

    overlays = import ./overlays {inherit inputs;};

    # Custom library that I use to create users and nixosSystems
    tyriaLib = import ./lib {inherit inputs overlays outputs;};

    users = {
      erin = tyriaLib.mkUser {
        userName = "erin";
        profiles = with user-profiles; [
          bat
          common
          desktop-packages
          direnv
          discord
          git
          github
          helix
          lazygit
          lutris
          mangohud
          prismlauncher
          ssh
          syncthing
          terminal-packages
          tweag
        ];
      };
    };
  in {
    # Custom packages
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit pkgs;}
    );

    # Exporting overlays for use whenever
    inherit overlays;

    # Custom modules
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      Gwen = tyriaLib.mkNixosSystem {
        hostName = "Gwen";
        hardwareModules = with nixos-hardware.nixosModules; [
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
          printing
          steam
          mozillavpn
        ];
      };
    };

    # TODO: Right now, home configurations are handled through the NixOS home-manager modules
    homeConfigurations = {};
  };
}
