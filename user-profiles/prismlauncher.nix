{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    jdk17
    glfw
  ];
}
