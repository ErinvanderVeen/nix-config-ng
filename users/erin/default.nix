{ ... }: {
  users.users.erin = {
    name = "erin";
    description = "Erin van der Veen";
    initialHashedPassword = "$y$j9T$xMVMs3Pdccm9jI1CUV4Be0$ruxg5.m4KHPS3OxQ6X/s6jKgmXx5ZBMsydbGjUIX05/";
    home = "/home/erin";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIER8TSugkBgvunwpyhvEhu65kkidfoUoq5Euup0ehuu/ erin@Trahearne"
    ];
  };

  home-manager.users.erin.home.stateVersion = "22.11";
}
