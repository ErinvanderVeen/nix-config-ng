{pkgs, ...}: {
  home.packages = with pkgs; [
    # logseq
    obs-studio
  ];
}
