{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    nixgl.auto.nixGLDefault
  ];
  nixGL = {
    packages = inputs.nixgl.packages;
  };
}

