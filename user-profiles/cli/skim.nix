{ ... }:
{
  programs.skim = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    changeDirWidgetOptions = [ "--preview 'eza -l {}'" ];
    fileWidgetOptions = [ "--preview 'bat {}'" ];
    historyWidgetOptions = [ "--exact" ];
  };
}
