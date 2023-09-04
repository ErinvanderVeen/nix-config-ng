# This module contains the home manager configuration that is only intended for the "kyjan" user.
{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      mixxx
      olive-editor # Support is probably ending soon (as of 2023-09-04)
      pitivi # Possible replacement for olive
      whatsapp-for-linux
    ];
  };
}
