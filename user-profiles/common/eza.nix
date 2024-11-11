{ ... }: {
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  home.shellAliases = {
    l = "eza -l --colour=auto --hyperlink -a --git -h";
  };

}
