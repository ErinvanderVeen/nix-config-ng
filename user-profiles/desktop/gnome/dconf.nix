{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
      ];
      last-selected-power-profile = "performance";
      remember-mount-password = true;
      welcome-dialog-last-shown-version = "44.2";
    };

    "org/gnome/Weather" = {
      locations = [
        (mkVariant [
          (mkUint32 2)
          (mkVariant [
            "Stockholm"
            "ESSB"
            true
            [
              (mkTuple [
                1.0358529110586345
                0.31328660073298215
              ])
            ]
            [
              (mkTuple [
                1.0355620170322046
                0.3150319299849765
              ])
            ]
          ])
        ])
      ];
    };

    "org/gnome/calendar" = {
      active-view = "week";
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/amber-l.jxl";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/amber-d.jxl";
      primary-color = "#ff7800";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "us+altgr-intl"
        ])
      ];
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "caps:escape"
      ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = "yellow";
      clock-format = "24h";
      clock-show-date = false;
      clock-show-seconds = false;
      clock-show-weekday = true;
      color-scheme = "default";
      cursor-size = 32;
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "Inter Variable 11";
      overlay-scrolling = true;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      left-handed = false;
      speed = 0.0;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      lock-enabled = false;
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/amber-l.jxl";
      primary-color = "#ff7800";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
      focus-mode = "click";
      resize-with-right-button = true;
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
      default-search-engine = "DuckDuckGo";
    };

    "org/gnome/evince/default" = {
      continuous = true;
      dual-page = false;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = true;
      sidebar-page = "thumbnails";
    };

    "org/gnome/gnome-session" = {
      auto-save-session = true;
    };

    "org/gnome/gnome-system-monitor" = {
      cpu-smooth-graph = true;
      cpu-stacked-area-chart = true;
      network-in-bits = true;
      network-total-in-bits = true;
      network-total-unit = false;
      show-dependencies = false;
      show-whose-processes = "user";
      smooth-refresh = true;
      update-interval = 1000;
    };

    "org/gnome/maps" = {
      map-type = "MapsVectorSource";
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = false;
      edge-tiling = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Super>Left" ];
      toggle-tiled-right = [ "<Super>Right" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "xdg-terminal-exec";
      name = "terminal";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = [
        (mkVariant [
          (mkUint32 2)
          (mkVariant [
            "Stockholm"
            "ESSB"
            true
            [
              (mkTuple [
                1.0358529110586345
                0.31328660073298215
              ])
            ]
            [
              (mkTuple [
                1.0355620170322046
                0.3150319299849765
              ])
            ]
          ])
        ])
      ];
    };
  };
}
