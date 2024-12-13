{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.nextcloud = {
    enable = true;
    hostName = "Mordremoth.local";
    database.createLocally = true;
    config = {
      adminpassFile = "/etc/nextcloud-pass-file";
    };
    package = pkgs.nextcloud30;
    appstoreEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        contacts
        calendar
        tasks
        maps
        memories
        music
        notes
        ;
    };
    settings = {
      "memories.exiftool" = lib.getExe pkgs.exiftool;
      "memories.vod.ffmpeg" = lib.getExe pkgs.ffmpeg-headless;
      "memories.vod.ffprobe" = lib.getExe' pkgs.ffmpeg-headless "ffprobe";
    };
  };

  # All required for recognize
  environment.systemPackages = with pkgs; [
    gnumake # installation requirement
    nodejs_20 # runtime and installation requirement
    nodejs_20.pkgs.node-pre-gyp # installation requirement
    python3 # requirement for node-pre-gyp otherwise fails with exit code 236
    util-linux # runtime requirement for taskset
  ];

  systemd.services.nextcloud-setup = {
    script = ''
      export PATH=$PATH:/etc/profiles/per-user/nextcloud/bin:/run/current-system/sw/bin

      if [[ ! -e ${config.services.nextcloud.home}/store-apps/recognize/node_modules/@tensorflow/tfjs-node/lib/napi-v8/tfjs_binding.node ]]; then
        if [[ -d ${config.services.nextcloud.home}/store-apps/recognize/node_modules/ ]]; then
          cd ${config.services.nextcloud.home}/store-apps/recognize/node_modules/
          npm rebuild @tensorflow/tfjs-node --build-addon-from-source
        fi
      fi

      ln -sf ${lib.getExe pkgs.nodejs_20} ${config.services.nextcloud.datadir}/store-apps/recognize/bin/node
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
