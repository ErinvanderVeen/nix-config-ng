{ ... }:
{
  services.samba = {
    enable = true;
    settings = {
      global = {
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
      };
    };
    openFirewall = true;
  };
}
