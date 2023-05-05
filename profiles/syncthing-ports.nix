{pkgs, ...}: {
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 8384;
        to = 8384;
      }
    ];
  };
}
