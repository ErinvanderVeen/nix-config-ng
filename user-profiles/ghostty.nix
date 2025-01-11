{
  config,
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.ghostty);
    enableFishIntegration = true;
    installBatSyntax = true;
    settings = {
      theme = "dark:Adwaita Dark,light:Adwaita";
      command = "fish --login --interactive";
    };
  };
}
