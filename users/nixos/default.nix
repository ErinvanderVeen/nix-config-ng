{ ... }:
{
  users.users.nixos = {
    description = "default";
    initialHashedPassword = "$y$j9T$YL05DpRpKY0L9JEbeUvvu/$zdCZDf9iDJ0B3T9n2y7fKoIyHQhhB981Dcdff19Kqf9";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "media"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIER8TSugkBgvunwpyhvEhu65kkidfoUoq5Euup0ehuu/ erin@Trahearne"
    ];
  };

  home-manager.users.nixos.home.stateVersion = "22.11";
}
