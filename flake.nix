{
  description = "Erin's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
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
          dconf
          desktop-packages
          direnv
          discord
          git
          github
          helix
          lazygit
          lutris
          prismlauncher
          ssh
          syncthing
          terminal-packages
          tweag
        ];
      };

      maatje = tyriaLib.mkUser {
        userName = "maatje";
        profiles = with user-profiles; [
          common
          dconf
          desktop-packages
          discord
          git
          lutris
          prismlauncher
          syncthing
        ];
      };

      kyjan = tyriaLib.mkUser {
        userName = "kyjan";
        profiles = with user-profiles; [
          common
          dconf
          desktop-packages
          discord
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
          dconf
          desktop-packages
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
          printing
          steam
          mozillavpn
          update
        ];
      };

      Mordremoth = tyriaLib.mkNixosSystem {
        hostName = "Mordremoth";
        hardwareModules = with nixos-hardware.nixosModules; [
          common-cpu-intel
          common-pc
          common-pc-ssd
          common-pc-hdd
        ];
        users = with users; [
          nixos
          media
        ];
        profiles = with profiles; [
          common
          corectrl
          gnome
          jellyfin
          media-group
          mozillavpn
          samba
          syncthing
          syncthing-ports
          transmission
          update
        ];
      };

      Taimi = tyriaLib.mkNixosSystem {
        hostName = "Taimi";
        hardwareModules = with nixos-hardware.nixosModules; [
          common-cpu-intel
          common-gpu-nvidia-nonprime
          common-pc
          common-pc-ssd
        ];
        users = with users; [
          maatje
        ];
        profiles = with profiles; [
          common
          gnome
          steam
          mozillavpn
          update
        ];
      };

      Junkrat = tyriaLib.mkNixosSystem {
        hostName = "Junkrat";
        hardwareModules = with nixos-hardware.nixosModules; [
          common-cpu-intel
          common-cpu-intel-kaby-lake
          common-pc-laptop
          common-pc-laptop-ssd
        ];
        users = with users; [
          kyjan
        ];
        profiles = with profiles; [
          common
          gnome
          printing
          update
        ];
      };

      Tequatl = tyriaLib.mkNixosSystem {
        hostName = "Tequatl";
        hardwareModules = with nixos-hardware.nixosModules; [
          lenovo-thinkpad-x1-9th-gen
        ];
        users = with users; [
          erin
        ];
        profiles = with profiles; [
          common
          gnome
          printing
          update
          mozillavpn
        ];
      };

      Aurene = tyriaLib.mkNixosSystem {
        hostName = "Aurene";
        hardwareModules = with nixos-hardware.nixosModules; [
          common-cpu-intel
          common-cpu-intel-kaby-lake
          common-pc-laptop
          common-pc-laptop-ssd
        ];
        users = with users; [
          maatje
        ];
        profiles = with profiles; [
          common
          gnome
          steam
          mozillavpn
          update
        ];
      };
    };

    # TODO: Right now, home configurations are handled through the NixOS home-manager modules
    homeConfigurations = {};
  };
}
