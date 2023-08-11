{...}: {
  users.users.media = {
    name = "media";
    description = "Media Center User";
    initialHashedPassword = "$y$j9T$xMVMs3Pdccm9jI1CUV4Be0$ruxg5.m4KHPS3OxQ6X/s6jKgmXx5ZBMsydbGjUIX05/";
    home = "/home/media";
    isNormalUser = true;
    extraGroups = ["networkmanager" "media"];
  };

  home-manager.users.media.home.stateVersion = "23.05";
}
