{ lib, pkgs, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

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

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
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
      clock-show-weekday = false;
      color-scheme = "default";
      cursor-size = 32;
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "Inter Variable 11";
      icon-theme = "MoreWaita";
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

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      lock-enabled = false;
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/amber-l.jxl";
      primary-color = "#ff7800";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/gnome/desktop/wm/keybindings" = {
      maximize = [ "<Super>Up" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      unmaximize = [
        "<Super>Down"
      ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
      resize-with-right-button = true;
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
      default-search-engine = "DuckDuckGo";
    };

    "org/gnome/gnome-session" = {
      auto-save-session = true;
    };

    "org/gnome/gnome-system-monitor" = {
      cpu-smooth-graph = true;
      cpu-stacked-area-chart = true;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = false;
      edge-tiling = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/papers/default" = {
      continuous = true;
      dual-page = false;
      dual-page-odd-left = false;
      enable-spellchecking = false;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = true;
      sidebar-page = "links";
      sizing-mode = "automatic";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "${pkgs.xdg-terminal-exec}/bin/xdg-terminal-exec";
      name = "terminal";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "blur-my-shell@aunetx"
        "dash-to-dock@micxgx.gmail.com"
      ];
      remember-mount-password = true;
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };
  };
}
