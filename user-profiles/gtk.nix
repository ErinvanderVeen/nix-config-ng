{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
  };
}
