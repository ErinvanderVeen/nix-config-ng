{ ... }: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    host = "0.0.0.0";
    rocmOverrideGfx = "10.3.0";
    openFirewall = true;
  };
}
