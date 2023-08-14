{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # For google meet (FF works, but camera quality is greatly reduced)
      chromium
      slack
      tty-share
    ];
    # TODO: Re-introduce ifSupportedPkg
    # ++ lib.ifSupportedPkg slack
    # ++ lib.ifSupportedPkg zoom-us;
  };
}
