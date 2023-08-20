{pkgs, ...}: {
  programs.steam.enable = true;

  # Sharing the local library over the network
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 24070;
        to = 24070;
      }
      {
        from = 27015;
        to = 27050;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 3478;
        to = 3478;
      }
      {
        from = 4379;
        to = 4380;
      }
      {
        from = 27000;
        to = 27100;
      }
    ];
  };
}
