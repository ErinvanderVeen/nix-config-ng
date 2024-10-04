{
  networking = {
    networkmanager.enable = true;
    # network manager requires useDHCP to be false
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

    avahi = {
      enable = true;
      nssmdns4 = true;
      ipv6 = false;
      publish = {
        enable = true;
        userServices = true;
        workstation = true;
        addresses = true;
      };
    };
  };
}
