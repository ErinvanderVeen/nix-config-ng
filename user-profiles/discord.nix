{pkgs, ...}: {
  home = {
    # TODO: Re-introduce ifSupportedPkg
    # packages = pkgs.lib.ifSupportedPkg pkgs.discord;
    packages = [pkgs.discord];
  };
}
