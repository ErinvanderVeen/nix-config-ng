{
  # rtkit allows pipewire to get real time scheduling on demand (recommended by nixos wiki)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  hardware = {
    pulseaudio.enable = false;
    enableRedistributableFirmware = true;
  };
}
