# TODO: Split this file up like the cachix.nix file
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./cachix.nix];

  environment = {
    variables = {
      # Set a decent default editor
      EDITOR = "hx";
    };

    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      bat
      binutils
      bottom
      coreutils
      curl
      direnv
      dnsutils
      exa
      fd
      fzf
      git
      helix
      iputils
      jq
      moreutils
      nix-index
      pciutils
      ripgrep
      skim
      tealdeer
      trash-cli
      usbutils
      utillinux
      whois
    ];

    shellAliases = let
      ifSudo = lib.mkIf (config.security.sudo.enable);
    in {
      grep = "rg";

      # internet ip
      # TODO: explain this hard-coded IP address
      myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

      # nix
      n = "nix";
      nf = "n flake";
      nepl = "n repl '<nixpkgs>'";
      top = "btm";
      htop = "btm";

      # sudo
      s = ifSudo "sudo -E ";

      # cat
      cat = "bat";

      # systemd
      ctl = "systemctl";
      stl = ifSudo "s systemctl";
      utl = "systemctl --user";
      jtl = "journalctl";

      # NOTE: exa aliases are maintained by the exa home-manager module
    };
  };

  nixpkgs = {
    # enable unfree packages
    config.allowUnfree = true;
  };

  nix = {
    # Improve nix store disk usage
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;

    settings = {
      experimental-features = ["nix-command" "flakes"];

      # Give root user and wheel group special Nix privileges.
      trusted-users = ["root" "@wheel"];
      allowed-users = ["root" "@wheel"];

      # Improve nix store disk usage
      auto-optimise-store = true;
    };

    # Generally useful nix option defaults
    extraOptions = ''
      min-free = 536870912
      keep-outputs = false
      keep-derivations = false
      fallback = true
    '';
  };

  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = true;
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };

  # Sound
  sound.enable = true;
  # rtkit allows pipewire to get real time scheduling on demand (recommended by nixos wiki)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  hardware = {
    pulseaudio.enable = false;
    enableRedistributableFirmware = true;
  };

  services.fwupd.enable = true;

  programs.fish = {
    enable = true;
    promptInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';
  };

  time.timeZone = lib.mkDefault "Europe/Stockholm";

  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };

  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    # Service that makes Out of Memory Killer more effective
    earlyoom.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
      ipv6 = false;
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };
}
