{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.protonvpn;
in {
  options = {
    services.protonvpn = {
      enable = mkEnableOption "Enable ProtonVPN";

      autostart = mkOption {
        default = true;
        example = "true";
        type = types.bool;
        description = "Connect to ProtonVPN when NixOS boots. Visit https://account.protonmail.com/u/0/vpn/WireGuard to get a WireGuard certificate for the other options in this module";
      };

      interface = {
        name = mkOption {
          default = "protonvpn";
          type = types.str;
          description = "Interface name";
        };

        address = mkOption {
          example = ["192.168.2.1/24"];
          default = ["192.168.2.1/24"];
          type = with types; listOf str;
          description = lib.mdDoc "The IP addresses of the interface.";
        };

        listenPort = mkOption {
          default = 51820;
          type = with types; nullOr int;
          example = 51820;
        };

        privateKeyFile = mkOption {
          example = "/private/protonvpn_key";
          type = with types; nullOr str;
          default = null;
          description = lib.mdDoc ''
            Private key file taken from the generated certificate.
          '';
        };

        dns = {
          enable = mkOption {
            default = false;
            example = "true";
            type = types.bool;
            description = "Enable the DNS provided by ProtonVPN";
          };

          address = mkOption {
            default = "10.2.0.1";
            example = "10.2.0.1";
            type = types.str;
            description = "The IP address of the DNS provided by the VPN. See your Wireguard certificate.";
          };
        };
      };

      peer = {
        publicKey = mkOption {
          type = types.str;
          description = "The public key of the VPN endpoint. See your Wireguard certificate.";
        };

        endpoint = mkOption {
          example = "146.70.170.2:51820";
          type = types.str;
          description = "The endpoint of the VPN peer. See your Wireguard certificate.";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    networking.wg-quick.interfaces."${cfg.interface.name}" = {
      autostart = cfg.autostart;
      dns = lib.optional cfg.interface.dns.enable cfg.interface.dns.address;
      privateKeyFile = cfg.interface.privateKeyFile;
      address = cfg.interface.address;
      listenPort = cfg.interface.listenPort;

      peers = [
        {
          publicKey = cfg.peer.publicKey;
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = cfg.peer.endpoint;
        }
      ];
    };
  };
}
