{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      tty-share
    ];
  };
}
