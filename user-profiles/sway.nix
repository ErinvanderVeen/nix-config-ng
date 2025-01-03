{
  pkgs,
  config,
  lib,
  ...
}:
let
  bing = pkgs.writeShellScriptBin "bing" ''
    set -e

    if [ -z "$SWAYSOCK" ]; then
      export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
    fi

    wlpath=''${WALLPAPER_PATH:-"$HOME/wallpaper.jpg"}
    lswlpath=''${LOCK_SCREEN_WALLPAPER_PATH:-"$HOME/lockscreen_wallpaper.jpg"}
    output=''${WALLPAPER_OUTPUT:-"*"}
    baseurl="https://www.bing.com/"
    wluri=$(curl $baseurl"HPImageArchive.aspx?format=js&idx=0&n=20&mkt=en-GB" -s | jq '.images[].url' --raw-output | shuf -n 1)

    ${pkgs.curl}/bin/curl "$baseurl$wluri" -s > $wlpath

    pkill swaybg || true

    ${pkgs.sway}/bin/swaymsg "output $output bg $wlpath fill"

    ${pkgs.imagemagick}/bin/convert $wlpath -filter Gaussian -blur 0x8 -level 10%,90%,0.5 $lswlpath
  '';
in
{
  home.packages = with pkgs; [
    xdg-desktop-portal-wlr
    swaynotificationcenter
    bing
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      #assigns = null;
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
      #bindKeysToCode = null;
      colors = {
        background = "#132738";
        focused = {
          background = "#5555ff";
          border = "#fac661";
          childBorder = "#5555ff";
          indicator = "#5555ff";
          text = "#000000";
        };
        focusedInactive = {
          background = "#ff0000";
          border = "#ff0000";
          childBorder = "#ff0000";
          indicator = "#ffe50a";
          text = "#ff005d";
        };
        placeholder = {
          background = "#000000";
          border = "#000000";
          childBorder = "#000000";
          indicator = "#000000";
          text = "#ff005d";
        };
        unfocused = {
          background = "#000000";
          border = "#ff0000";
          childBorder = "#ff0000";
          indicator = "#ff0000";
          text = "#ff005d";
        };
        urgent = {
          background = "#555555";
          border = "#555555";
          childBorder = "#555555";
          indicator = "#555555";
          text = "#000000";
        };
      };
      #defaultWorkspace = null;
      #down = null;
      #floating = null;
      #focus = null;
      #fonts = null;
      gaps = {
        inner = 10;
        outer = 10;
        smartBorders = "on";
      };
      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
          xkb_options = "caps:swapescape";
          accel_profile = "flat";
          pointer_accel = "-0.2";
        };
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        # Don't override defaul keybinds
        lib.mkOptionDefault {
          "${modifier}+Shift+n" = "exec swaync-client -t -swb -sw";
          "${modifier}+Shift+s" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy area";

          # Mediakeys
          "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
          "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
          "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
          "XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";
          "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 10%- -q";
          "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s +10% -q";
        };
      #keycodebindings = null;
      #left = null;
      #menu = "${pkgs.sirula}/bin/sirula";
      #modes = null;
      modifier = "Mod4";
      #output = null;
      #right = null;
      #seat = null;
      startup = [
        { command = "${pkgs.autotiling}/bin/autotiling"; }
        {
          command = "${pkgs.swaywsr}/bin/swaywsr";
          always = true;
        }
        { command = "${pkgs.swaynotificationcenter}/bin/swaync"; }
        { command = "${bing}/bin/bing"; }
      ];
      terminal = "${pkgs.alacritty}/bin/alacritty";
      #up = null;
      #window = null;
      workspaceAutoBackAndForth = false;
      #workspaceLayout = null;
      #workspaceOutputAssign = null;
    };
    #extraConfig = null;
    #extraOptions = null;
    #extraSessionCommands = null;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
  };

  programs.waybar = {
    enable = true;
    settings = { };
  };
}
