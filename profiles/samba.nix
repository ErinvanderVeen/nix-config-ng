{...}: {
  services.samba = {
    enable = true;
    extraConfig = ''
      hosts allow = 192.168.0. 127.0.0.1 localhost
    '';
    openFirewall = true;
  };
}
